import 'package:cuidador_app_mobile/UI/Pages/LoginModule/Models/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageMain extends StatefulWidget {
  const LoginPageMain({super.key});
  @override
  State<LoginPageMain> createState() => _LoginPageMainState();
}

class _LoginPageMainState extends State<LoginPageMain> {
  
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}