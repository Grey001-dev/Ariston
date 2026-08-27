import 'package:ariston/custom_input_field.dart';
import 'package:ariston/google_auth_button.dart';
import 'package:ariston/primary_action_button.dart';
import 'package:ariston/sign_up_page.dart';
import 'package:flutter/material.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.school,
                    color: Color(0xFF003FB1),
                    size: 28.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Ariston',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003FB1),
                    )
                  )
                ],
              ),
              SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                    color: Color(0xFF0F2B6B).withValues(alpha: 0.1),
                    blurRadius: 28.0,
                    offset: Offset(0, 6),
                    spreadRadius: 0.0,
                  )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 22.0),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF12172B),
                      )
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Log in to continue your UTME preparation',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 22.0),
                    GoogleAuthButton(
                      buttonText: 'Sign in with Google',
                      onPressed: () {
                        // Handle Google sign in implementation.
                      }
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Expanded(
                          child: Divider(
                            color: Color(0xFFE1E2E4),
                            thickness: 1.0,
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Color(0xFF737686),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFFE1E2E4),
                            thickness: 1.0,
                          )
                        ),
                      ]
                    ),
                    const SizedBox(height: 25.0),
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
                      isPassword: true
                    ),
                    const SizedBox(height: 16.0),
                    PrimaryActionButton(
                      buttonText: 'Sign In',
                      onPressed: () {
                        // Implement the sign-in part.
                      }
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New to Ariston"?',
                          style: TextStyle(
                            color: Color(0xFF434654),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          )
                          ),
                          SizedBox(width: 4.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage()
                                )
                              );
                          },
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Color(0xFF003FB1),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              )
                            )
                          )
                      ]
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    ); 
  }
}