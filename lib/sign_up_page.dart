import 'package:ariston/custom_input_field.dart';
import 'package:ariston/google_auth_button.dart';
import 'package:ariston/primary_action_button.dart';
import 'package:ariston/services/auth_service.dart';
import 'package:ariston/sign_in_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final AuthService _authService = AuthService();
  // Controllers.
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get screen dimensions using MediaQuery
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth >= 600;

    final horizontalPadding = isTablet ? 48.0 : (isSmallScreen ? 16.0 : 24.0);
    final cardPadding = isSmallScreen ? 16.0 : 24.0;
    final titleFontSize = isSmallScreen ? 20.0 : (isTablet ? 28.0 : 24.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: screenHeight * 0.02, // 2% of screen height
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.school,
                        color: const Color(0xFF003FB1),
                        size: isSmallScreen ? 24.0 : 28.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Ariston',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF003FB1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03), // Dynamic vertical spacing
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F2B6B).withValues(alpha: 0.1),
                          blurRadius: 28.0,
                          offset: const Offset(0, 6),
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: isSmallScreen ? 10.0 : 22.0),
                        Text(
                          'Create an account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF12172B),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Begin your journey to academic excellence',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: isSmallScreen ? 14.0 : 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 22.0),
                        GoogleAuthButton(
                          buttonText: 'Sign up with Google',
                          onPressed: () async {
                            final result = await _authService.signInWithGoogle();
                            if (!context.mounted) return;

                            if (result['success'] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result['message'] ?? 'Signed up with Google!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result['message'] ?? 'Google sign up failed'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                color: Color(0xFFE1E2E4),
                                thickness: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Color(0xFF737686),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFFE1E2E4),
                                thickness: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        CustomInputField(
                          labelText: 'Username',
                          hinticon: Icons.person,
                          hintText: 'e.g Tosin',
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomInputField(
                          labelText: 'Email',
                          hinticon: Icons.mail,
                          hintText: 'you@example.com',
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomInputField(
                          labelText: 'Password',
                          hinticon: Icons.lock,
                          hintText: '******',
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20.0),
                        PrimaryActionButton(
                          buttonText: 'Get started',
                          onPressed: () async {
                            final userValidationError = _validateUserInput();
                            if (userValidationError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(userValidationError),
                                  backgroundColor: Colors.red,
                                )
                              );
                            }
                            final result = await _authService.registerUser(
                              name: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text
                            );
                            if (!context.mounted) return;
                            if (result['success'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(result['message'] ?? 'Account created!')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message'] ?? 'Sign up failed'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: const Color(0xFF434654),
                                fontSize: isSmallScreen ? 12.0 : 14.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: const Color(0xFF003FB1),
                                  fontSize: isSmallScreen ? 12.0 : 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  String? _validateUserInput() {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      return 'Please fill in all fields.';
    } else if (password.length < 6) {
      return 'Password must be at least 6 character long.';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }
}