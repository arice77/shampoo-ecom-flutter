import 'package:ecom/screens/homw_scree.dart';
import 'package:ecom/services/firebase_auth.dart';
import 'package:ecom/widgets/auth_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _isSignUp = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _isSignUp ? ' Create Account' : ' Login',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Fill Your Details Or Continue \nWith Social Media',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_isSignUp)
                AuthTextField(
                    controller: _nameController,
                    hintText: 'Full Name',
                    iconData: Icons.account_circle_outlined),
              AuthTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  iconData: Icons.mail),
              AuthTextField(
                  controller: _passController,
                  hintText: 'Password',
                  iconData: Icons.remove_red_eye_outlined),
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.grey),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 18, bottom: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            if (_isSignUp) {
                              await FirebaseAuthService()
                                  .signUp(
                                      _nameController.text,
                                      _emailController.text,
                                      _passController.text,
                                      context)
                                  .then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (firebaseAuth.currentUser != null) {
                                  Navigator.of(context).pushReplacementNamed(
                                      HomeScreen.routeNmae);
                                }
                              });
                            } else {
                              await FirebaseAuthService()
                                  .login(_emailController.text,
                                      _passController.text, context)
                                  .then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (firebaseAuth.currentUser != null) {
                                  Navigator.of(context).pushReplacementNamed(
                                      HomeScreen.routeNmae);
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              _isSignUp ? 'Sign Up' : 'Login',
                              style: const TextStyle(fontSize: 25),
                            ),
                          )),
                    ),
              if (!_isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isSignUp
                          ? 'Already have an account ?'
                          : "Don't have an account ?",
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                          });
                        },
                        child: Text(
                          _isSignUp ? 'Login' : 'Sign Up',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ))
                  ],
                )
            ],
          ),
        ),
      )),
    );
  }
}
