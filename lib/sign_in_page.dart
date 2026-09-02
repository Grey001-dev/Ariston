import 'package:ariston/custom_input_field.dart';
import 'package:ariston/google_auth_button.dart';
import 'package:ariston/primary_action_button.dart';
import 'package:ariston/services/auth_service.dart';
import 'package:ariston/sign_up_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Fetch viewport metrics
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
              vertical: screenHeight * 0.02,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 480.0, // Limits container width on tablets/desktop
              ),
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
                  SizedBox(height: screenHeight * 0.03),
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
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF12172B),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Log in to continue your UTME preparation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: isSmallScreen ? 14.0 : 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 22.0),
                        GoogleAuthButton(
                          buttonText: 'Sign in with Google',
                          onPressed: () async {
                          final result = await _authService.signInWithGoogle();
                          if (!context.mounted) return;

                          if (result['success'] == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result['message'] ?? 'Signed in with Google!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result['message'] ?? 'Google sign in failed'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        ),
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
                          buttonText: 'Sign In',
                          onPressed: () async {
                            final result = await _authService.loginUser(
                              email: _emailController.text,
                              password: _passwordController.text
                            );
                            if (!context.mounted) return;
                            if (result['success'] == true) {
                              debugPrint('Success');
                                // Add the navigation logic here
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message'] ?? 'Sign in failed'),
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
                              'New to Ariston?',
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
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Get Started',
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
}