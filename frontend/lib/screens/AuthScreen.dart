import 'package:flip/components/common/CustomButton.dart';
import 'package:flip/components/common/CustomTextField.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Welcome 🍃',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            Visibility(
                visible: _auth == Auth.signup,
                child: Container(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(children: [
                      CustomTextField(
                        placeHolder: 'Name',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        placeHolder: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        placeHolder: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(text: 'Sign up', onTap: () {})
                    ]),
                  ),
                )),
            ListTile(
              title: const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            Visibility(
                visible: _auth == Auth.signin,
                child: Container(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        placeHolder: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        placeHolder: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(text: 'Sign In', onTap: () {})
                    ]),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
