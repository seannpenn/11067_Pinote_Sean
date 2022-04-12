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
        title: const Center(child: Text('Login')),
        backgroundColor: Colors.teal[400],
      ),
      // backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Todo app',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
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
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: "Username",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person,
                                color: _unCon.text.isEmpty
                                    ? Colors.black
                                    : Colors.teal[400],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: const BorderSide(width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF26A69A), width: 2.0),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          controller: _unCon,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Password',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.lock,
                                color: _passCon.text.isEmpty
                                    ? Colors.black
                                    : Colors.teal[400],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: const BorderSide(width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF26A69A), width: 2.0),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed:
                                        (_formKey.currentState?.validate() ??
                                                false)
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
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        primary: (_formKey.currentState
                                                    ?.validate() ??
                                                false)
                                            ? Colors.teal[400]
                                            : Colors.grey,
                                        padding: const EdgeInsets.all(15)),
                                    child: const Text('Register'),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed:
                                        (_formKey.currentState?.validate() ??
                                                false)
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
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        primary: (_formKey.currentState
                                                    ?.validate() ??
                                                false)
                                            ? Colors.teal[400]
                                            : Colors.grey,
                                        padding: const EdgeInsets.all(15)),
                                    child: const Text('Log in'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
