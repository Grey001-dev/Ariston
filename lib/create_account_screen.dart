import 'package:ariston/app_wordmark.dart';
import 'package:ariston/custom_input_field.dart';
import 'package:ariston/google_auth_button.dart';
import 'package:ariston/primary_action_button.dart';
import 'package:ariston/responsive_page.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'sign_in_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _authService = AuthService();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  Future<void> _handleGetStarted() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('Passwords do not match');
      return;
    }
    setState(() => _isLoading = true);
    final result = await _authService.registerUser(
      name: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      // TO be done: persist result['token'] somewhere (secure storage, a
      // provider, etc.) before you need it for authenticated requests.
      _goHome();
    } else {
      _showMessage(result['message'] ?? 'Could not create account');
    }
  }

  Future<void> _handleGoogleSignUp() async {
    setState(() => _isGoogleLoading = true);
    final result = await _authService.signInWithGoogle();
    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    if (result['success'] == true) {
      // TO be done: persist result['token'] somewhere (secure storage, a
      // provider, etc.) before you need it for authenticated requests.
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
            'Create Account',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          const SizedBox(height: 6),
          const Text(
            'Begin your journey to academic excellence.',
            style: TextStyle(fontSize: 14, color: Color(0xFF5A6178)),
          ),
          const SizedBox(height: 24),
          GoogleAuthButton(
            buttonText: _isGoogleLoading ? 'Signing up…' : 'Sign up with Google',
            onPressed: _isGoogleLoading ? () {} : _handleGoogleSignUp,
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
            labelText: 'Username',
            hintText: 'Choose a username',
            controller: _usernameController,
            helperText: 'maximum of 15-20 characters',
          ),
          // Smaller gap here on purpose: the helper text above already
          // adds its own visual space, so this plus that line lands at
          // the same total distance as the plain 16px gap used below.
          const SizedBox(height: 2),
          CustomInputField(
            labelText: 'Email',
            hintText: 'you@example.com',
            controller: _emailController,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            labelText: 'Password',
            hintText: 'Create a password',
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            controller: _confirmPasswordController,
            isPassword: true,
          ),
          const SizedBox(height: 28),
          PrimaryActionButton(
            buttonText: 'Get Started',
            onPressed: _handleGetStarted,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 16),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text('Already have an account? ', style: TextStyle(fontSize: 13, color: Color(0xFF5A6178))),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                  ),
                  child: const Text(
                    'Sign In',
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