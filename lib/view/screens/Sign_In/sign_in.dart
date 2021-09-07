import 'package:flutter/material.dart';
import 'package:muhammad/helper/size.dart';
import 'package:muhammad/view/screens/Sign_In/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top:
                  ScreenSize(context: context).getProportionateScreenHeight(16),
            ),
            child: Text(
              "Sign In",
              style: TextStyle(
                fontSize: ScreenSize(context: context)
                    .getProportionateScreenWidth(26),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  ScreenSize(context: context).getProportionateScreenWidth(18),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenSize(context: context)
                        .getProportionateScreenHeight(10),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenSize(context: context)
                          .getProportionateScreenWidth(26),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenSize(context: context)
                        .getProportionateScreenHeight(80),
                  ),
                  SignForm(),
                  SizedBox(
                    height: ScreenSize(context: context)
                        .getProportionateScreenHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          fontSize: ScreenSize(context: context)
                              .getProportionateScreenWidth(15),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('\SignUpScreen');
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: ScreenSize(context: context)
                                  .getProportionateScreenWidth(15),
                              color: Colors.blue),
                        ),
                      ),
                    ],
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
