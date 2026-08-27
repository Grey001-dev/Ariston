import 'package:ariston/custom_input_field.dart';
import 'package:ariston/google_auth_button.dart';
import 'package:ariston/primary_action_button.dart';
import 'package:ariston/sign_in_page.dart';
import 'package:flutter/material.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    // final screenWidth = MediaQuery.of(context).size.width;

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
                      'Create an account',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF12172B),
                      )
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Begin your journey to academic excellence',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 22.0),
                    GoogleAuthButton(
                      buttonText: 'Sign up with Google',
                      onPressed: () {
                        // Handle Google sign up implementation.
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
                      isPassword: true
                    ),
                    const SizedBox(height: 16.0),
                    PrimaryActionButton(
                      buttonText: 'Get started',
                      onPressed: () {
                        // Implement the sign-up part.
                      }
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
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
                                  builder: (context) => SignInPage()
                                )
                              );
                            },
                            child: Text(
                              'Sign In',
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