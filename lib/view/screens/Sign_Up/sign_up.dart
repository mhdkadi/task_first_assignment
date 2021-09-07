import 'package:flutter/material.dart';
import 'package:muhammad/helper/size.dart';
import 'package:muhammad/view/screens/Sign_Up/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            top: ScreenSize(context: context).getProportionateScreenHeight(16),
            right: ScreenSize(context: context).getProportionateScreenWidth(58),
          ),
          child: Center(
            child: Text(
              "Sign Up",
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
                  ScreenSize(context: context).getProportionateScreenWidth(19),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenSize(context: context)
                        .getProportionateScreenHeight(20),
                  ),
                  Text(
                    "Register Account",
                    style: TextStyle(
                      fontSize: ScreenSize(context: context)
                          .getProportionateScreenWidth(26),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: ScreenSize(context: context)
                          .getProportionateScreenWidth(1.4),
                    ),
                  ),
                  Text(
                    "Complete your details ",
                    style: TextStyle(
                      fontSize: ScreenSize(context: context)
                          .getProportionateScreenWidth(13),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenSize(context: context)
                        .getProportionateScreenHeight(10),
                  ),
                  SignUpForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
