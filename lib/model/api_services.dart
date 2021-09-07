import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiAuthentication {
  Dio dio = Dio();

  Future<String> signInPostRequest({
    String? email,
    String? password,
    required BuildContext context,
  }) async {
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMsg = FirebaseMessaging.instance;
    dynamic userFcmToken = await _firebaseMsg.getToken();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    dynamic response = await http.post(
      Uri.parse('https://flutter--task.herokuapp.com/auth/login'),
      headers: {"content-type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
        'FCM_token': userFcmToken,
      }),
    );
    if (response.statusCode == 200) {
      _prefs.setString('email', "$email");
      _prefs.setString('FCM_token', userFcmToken);
      _prefs.setString('status', 'Logged In');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('\ProfileScreen', (route) => false);
      return "You Are Logged In Successfully";
    } else if ((response.statusCode == 404 &&
            response.body == "{\"message\":\"password incorrect\"}") ||
        (response.statusCode == 404 &&
            response.body == "{\"message\":\"user not found\"}")) {
      return "Wrong Email or Password";
    } else {
      return "LogIn Failed Connection Error";
    }
  }

  Future<String> signUpPostRequest({
    String? email,
    String? password,
    String? name,
    String? phone,
    required String userImgPath,
    required String userImgname,
    required BuildContext context,
  }) async {
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMsg = FirebaseMessaging.instance;
    dynamic userFcmToken = await _firebaseMsg.getToken();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({
        'userImg':
            await MultipartFile.fromFile(userImgPath, filename: userImgname),
        'name': name,
        'password': password,
        'FCM_token': userFcmToken,
        'email': email,
        'phone': phone,
      });
      Response response = await dio.post(
          'https://flutter--task.herokuapp.com/auth/signUp',
          data: formData);
      if (response.statusCode == 201) {
        _prefs.setString('email', "$email");
        _prefs.setString('FCM_token', userFcmToken);
        _prefs.setString('status', 'Logged In');
        Navigator.of(context)
            .pushNamedAndRemoveUntil('\ProfileScreen', (route) => false);
        return "You Are Signed Up Successfully";
      } else if (response.statusCode == 404 &&
          response.data ==
              "{\"message\":\"Email or phone number is used already\"}") {
        return "Email or phone number is used already";
      } else {
        return "SignUp Failed Connection Error";
      }
    } catch (e) {
      return 'SignUp Failed Connection Error';
    }
  }
}
