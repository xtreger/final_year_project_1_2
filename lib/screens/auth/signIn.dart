import 'package:final_year_project_1_2/screens/auth/decorations.dart';
import 'package:final_year_project_1_2/screens/auth/signInUpBar.dart';
import 'package:final_year_project_1_2/config/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key, @required this.onRegisterClicked}) : super(key: key);

  final VoidCallback onRegisterClicked;

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.isSubmitting();
    return SignInForm(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LoginTitle(title: 'Safe\nParcel.'),
                )),
            Expanded(
                flex: 4,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: EmailTextFormField(
                          decoration: signInInputDecoration(hintText: 'Email')),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: PasswordTextFormField(
                          decoration:
                          signInInputDecoration(hintText: 'Password')),
                    ),
                    SignInBar(
                      isLoading: isSubmitting,
                      label: "Sign in",
                      onPressed: () {
                        context.signInWithEmailAndPassword();
                      },
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              onRegisterClicked?.call();
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.black54),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'SIGN UP',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ))),
                  ],
                )),

          ],
        ),
      ),
    );
  }
}
