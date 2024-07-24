import 'package:cuidador_app_mobile/UI/Pages/Contrato/contrato_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/resumen_cont_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/FeedPage/feed_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/Introduction/introduction_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/LoginModule/login_page_main.dart';
import 'package:get/get.dart';

import '../../UI/Pages/Contrato/confirmacion_cont_page.dart';
import '../../UI/Pages/SelectProfile/select_profile_page.dart';

class Routes {

  static List<GetPage> routes = [
    GetPage(name: '/login', page: () => LoginPageMain()),
    GetPage(name: '/introduction', page: () => IntroductionPageMain()),
    GetPage(name: '/home', page: () => FeedPageMain()),
    GetPage(name: '/contratar', page: () => ContratoPageMain()),
    GetPage(name: '/select_profile', page: () => SelectProfilePage()),
    GetPage(name: '/resumen_contrato', page: () => ResumenContPageMain()),
    GetPage(name: '/confirmacion_cont', page: () => ConfirmacionContPage()),
  ];

}


