import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService{
  final String baseUrl = dotenv.env['BASE_URL']!;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

   Future<void> initGoogleSignIn() async {
    await _googleSignIn.initialize(
      serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
    );
  }

  Future<Map<String, dynamic>> registerUser ({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/routes/register'),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      })
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) { 
      // Success
      return {'success': true, 'token': data['token'], 'message': data['message']};
    } else {
      // Failure
      return {'success': false, 'message': data['message']};
    }
  }

  Future<Map<String, dynamic>> loginUser ({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/routes/login'),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      })
    );
    
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) { 
      // Success
      return {'success': true, 'token': data['token'], 'message': data['message']};
    } else {
      // Failure
      return {'success': false, 'message': data['message']};
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    late final GoogleSignInAccount googleUser;

    try {
      googleUser = await _googleSignIn.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return {'success': false, 'message': 'You closed the Google sign in window.'};
      }
      return {'success': false, 'message': 'Google sign in error: ${e.description}'};
    }

    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      return {'success': false, 'message': 'Could not get Google ID token'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/routes/google'),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode({'idToken': idToken}),
      );

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('BODY: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'token': data['token'], 'message': data['message']};
      } else {
        return {'success': false, 'message': data['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }
}