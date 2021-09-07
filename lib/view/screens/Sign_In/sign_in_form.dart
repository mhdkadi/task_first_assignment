import 'package:flutter/material.dart';
import 'package:muhammad/model/api_services.dart';
import 'package:muhammad/view/const.dart';
import 'package:muhammad/view/error.dart';
import 'package:muhammad/helper/size.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  ApiAuthentication _auth = ApiAuthentication();
  String? email;
  String? password;
  bool? remember = false;
  List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void signIn() async {
    setState(() {
      errors = [];
    });
    await _auth
        .signInPostRequest(context: context, email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(10),
          ),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Since i don't have a password reset Api Url, so this onTap will do nothing
                },
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(20),
          ),
          SizedBox(
            width: double.infinity,
            height:
                ScreenSize(context: context).getProportionateScreenHeight(56),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  signIn();
                }
              },
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: ScreenSize(context: context)
                      .getProportionateScreenWidth(17),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        hintText: "Enter your email",
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
      ),
    );
  }
}
