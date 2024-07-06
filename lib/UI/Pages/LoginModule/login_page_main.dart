
import 'package:cuidador_app_mobile/UI/Pages/LoginModule/Models/login_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/LoginModule/Modules/home_login_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageMain extends StatelessWidget {
  LoginController con = Get.put(LoginController());
  HomeLoginModule login = Get.put(HomeLoginModule());

  @override
  Widget build(BuildContext context) { 
    return Material(
      child: login.loginHomeModule()
    );
  }
}