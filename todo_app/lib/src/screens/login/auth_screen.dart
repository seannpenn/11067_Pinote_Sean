import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';
import 'package:todo_app/src/screens/todos/todo_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          if (_authController.currentUser == null) {
            return AuthScreen(_authController);
          } else {
            return TodoHomeScreen(_authController);
          }
        });
  }
}

class AuthScreen extends StatefulWidget {
  final AuthController auth;
  const AuthScreen(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  String prompts = '';
  AuthController get _auth => widget.auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF303030),
      ),
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                onChanged: () {
                  _formKey.currentState?.validate();
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        prompts,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Username'),
                      controller: _unCon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      controller: _passCon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed:
                                  (_formKey.currentState?.validate() ?? false)
                                      ? () {
                                          String result = _auth.register(
                                              _unCon.text, _passCon.text);
                                          setState(() {
                                            prompts = result;
                                          });
                                        }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  primary: (_formKey.currentState?.validate() ??
                                          false)
                                      ? const Color(0xFF303030)
                                      : Colors.grey),
                              child: const Text('Register'),
                            ),
                            ElevatedButton(
                              onPressed:
                                  (_formKey.currentState?.validate() ?? false)
                                      ? () {
                                          bool result = _auth.login(
                                              _unCon.text, _passCon.text);
                                          if (!result) {
                                            setState(() {
                                              prompts =
                                                  'Error logging in, username or password may be incorrect or the user has not been registered yet.';
                                            });
                                          }
                                        }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  primary: (_formKey.currentState?.validate() ??
                                          false)
                                      ? const Color(0xFF303030)
                                      : Colors.grey),
                              child: const Text('Log in'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
