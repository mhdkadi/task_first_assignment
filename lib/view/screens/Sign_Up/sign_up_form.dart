import 'package:flutter/material.dart';
import 'package:muhammad/model/api_services.dart';
import 'package:muhammad/view/const.dart';
import 'package:muhammad/view/error.dart';
import 'package:muhammad/helper/size.dart';
import 'package:image_picker/image_picker.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  ApiAuthentication _auth = ApiAuthentication();
  String? email;
  String? phone;
  String? name;
  String? password;
  String? conformPassword;
  bool remember = false;
  XFile? image;
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

  void signUp() async {
    setState(() {
      errors = [];
    });
    await _auth
        .signUpPostRequest(
            email: email,
            password: password,
            name: name,
            phone: phone,
            userImgPath: image!.path,
            userImgname: image!.name,
            context: context)
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
          buildNameFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(30),
          ),
          buildEmailFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(30),
          ),
          buildPhoneFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(30),
          ),
          buildConformPassFormField(),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(20),
          ),
          Row(
            children: [
              Text(
                'Profile Picture:',
                style: TextStyle(
                  fontSize: ScreenSize(context: context)
                      .getProportionateScreenWidth(16),
                ),
              ),
              SizedBox(
                width: ScreenSize(context: context)
                    .getProportionateScreenWidth(16),
              ),
              image == null
                  ? TextButton(
                      onPressed: () async {
                        image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        removeError(error: kImageNullError);
                        setState(() {});
                      },
                      child: Text('Select an image'),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize(context: context)
                            .getProportionateScreenWidth(14),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: ScreenSize(context: context)
                                .getProportionateScreenWidth(140),
                            child: Text(
                              image!.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                image = null;
                              });
                            },
                            icon: Icon(Icons.cancel_outlined),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          FormError(errors: errors),
          SizedBox(
            height:
                ScreenSize(context: context).getProportionateScreenHeight(40),
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
                if (_formKey.currentState!.validate() && image != null) {
                  _formKey.currentState!.save();
                  signUp();
                } else if (image == null) {
                  addError(error: kImageNullError);
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && password == value) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
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
        }
        if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        password = value;
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
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        }
        if (emailValidatorRegExp.hasMatch(value)) {
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
        hintText: "Enter your email",
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.length == 10) {
          removeError(error: kWrongPhoneError);
        }
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNullError);
          return "";
        } else if (value.length != 10) {
          addError(error: kWrongPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter your phone number",
        labelStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(16),
        ),
        hintStyle: TextStyle(
          fontSize:
              ScreenSize(context: context).getProportionateScreenWidth(15),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }
}
