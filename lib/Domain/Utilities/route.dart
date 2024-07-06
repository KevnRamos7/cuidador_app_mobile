import 'package:cuidador_app_mobile/UI/Pages/Home/home_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/Introduction/introduction_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/LoginModule/login_page_main.dart';
import 'package:get/get.dart';

class Routes {

  static List<GetPage> routes = [
    GetPage(name: '/login', page: () => LoginPageMain()),
    GetPage(name: '/introduction', page: () => IntroductionPageMain()),
    GetPage(name: '/home', page: () => HomePageMain()),
  ];

}