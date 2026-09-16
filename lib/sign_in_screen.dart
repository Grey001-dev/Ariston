import 'package:ariston/app_wordmark.dart';
import 'package:ariston/custom_input_field.dart';
import 'package:ariston/google_auth_button.dart';
import 'package:ariston/primary_action_button.dart';
import 'package:ariston/responsive_page.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'create_account_screen.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    final result = await _authService.loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      _goHome();
    } else {
      _showMessage(result['message'] ?? 'Could not sign in');
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);
    final result = await _authService.signInWithGoogle();
    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    if (result['success'] == true) {
      _goHome();
    } else {
      _showMessage(result['message'] ?? 'Google sign in failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const AppWordmark(),
          const SizedBox(height: 28),
          const Text(
            'Welcome Back',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          const SizedBox(height: 6),
          const Text(
            'Log in to continue your academic journey',
            style: TextStyle(fontSize: 14, color: Color(0xFF5A6178)),
          ),
          const SizedBox(height: 24),
          GoogleAuthButton(
            buttonText: _isGoogleLoading ? 'Signing in…' : 'Sign in with Google',
            onPressed: _isGoogleLoading ? () {} : _handleGoogleSignIn,
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: Divider(color: Color(0xFFE4E7F0))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('OR', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFA7ABBD))),
              ),
              Expanded(child: Divider(color: Color(0xFFE4E7F0))),
            ],
          ),
          const SizedBox(height: 20),
          CustomInputField(
            labelText: 'Email',
            hintText: 'you@example.com',
            controller: _emailController,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),
          PrimaryActionButton(
            buttonText: 'Sign In',
            onPressed: _handleSignIn,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text('New to Ariston? ', style: TextStyle(fontSize: 13, color: Color(0xFF5A6178))),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreateAccountScreen()),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 13, color: Color(0xFF003FB1), fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}