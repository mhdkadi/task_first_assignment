import 'package:flutter/material.dart';
import 'package:muhammad/view/screens/Sign_In/sign_in.dart';
import 'package:muhammad/view/screens/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutPage extends StatefulWidget {
  const RoutPage({ Key? key }) : super(key: key);

  @override
  _RoutPageState createState() => _RoutPageState();
}

class _RoutPageState extends State<RoutPage> {
  dynamic _status;
  
  void getStatus()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _status=_prefs.getString('status');
    });
  }

  @override
  void initState() { 
    super.initState();
    getStatus();
  }
  
  @override
  Widget build(BuildContext context) {
    if(_status=='Logged In'){
      return ProfileScreen();
    }else{
      return SignInScreen();
    }
  }
}