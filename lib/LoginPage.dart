import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultTextFormField(
                    label: 'Email Address',
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    prefix: Icons.email,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email is not correct';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                  defaultTextFormField(
                    label: 'Password',
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                    prefix: Icons.lock,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password can not be Empty';
                      }
                      return null;
                    },
                    isPassword: isPassword,
                    suffix:isPassword? Icons.visibility :Icons.visibility_off,
                    suffixPressed: (){
                      setState(() {
                        isPassword =!isPassword;
                      });
                    }

                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      child: Text("LOGIN"),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account!?"),
                      TextButton(onPressed: () {}, child: Text("Register now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
