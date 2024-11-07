import 'package:cuidador_app_mobile/UI/Pages/Contrato/contrato_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/resumen_cont_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/complete_review_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/cuidador_review_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/list_comentarios_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/Dashboard/dashboard_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/FeedPage/feed_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/Feedback/feedback_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Modules/add_credit_card_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/finanzas_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/Introduction/introduction_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/estatus_contrato_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/listcontrato_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/LoginModule/login_page_main.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/my_profile_cliente_page.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProfilesPreview/ProfileCuidador/profile_cuidador_main.dart';
import 'package:get/get.dart';

import '../../UI/Pages/Contrato/confirmacion_cont_page.dart';
import '../../UI/Pages/ProgressContract/progress_contract_main.dart';
import '../../UI/Pages/SelectProfile/select_profile_page.dart';

class Routes {

  static List<GetPage> routes = [
    GetPage(name: '/login', page: () => LoginPageMain()),
    GetPage(name: '/introduction', page: () => IntroductionPageMain()),
    GetPage(name: '/home', page: () => FeedPageMain()),
    GetPage(name: '/contratar', page: () => ContratoPageMain()),
    GetPage(name: '/select_profile', page: () => SelectProfilePage()),
    GetPage(name: '/resumen_contrato', page: () => ResumenContPageMain()),
    GetPage(name: '/confirmacion_cont', page: () => const ConfirmacionContPage()),
    GetPage(name: '/previewProfileCuidador', page: () => ProfileCuidadorMain()),
    // GetPage(name: '/previewProfileCliente', page: () => ProfileCuidadorMain()),
    GetPage(name: '/list_contratos', page: () => ListcontratoPageMain()),
    GetPage(name: '/my_profile_cliente', page: () => MyProfileClientePage()),
    GetPage(name: '/dashboard', page: () => DashboardPage()),
    GetPage(name: '/finanzas', page: () => FinanzasPage()),
    GetPage(name: '/add_credit_card', page: () => const AddCreditCardPage()),
    GetPage(name: '/cuidadorReview', page: () => CuidadorReview()),
    GetPage(name: '/completeReview', page: () => CompleteReviewPage()),
    GetPage(name: '/listComentarios', page: () => const ListComentariosPage()),

    GetPage(name: '/progressContract', page: () => ProgressContractMain()),
    GetPage(name: '/estatusContratoCliente', page: () => const EstatusContratoCliente()),
    GetPage(name: '/feedback', page: () => FeedbackPageMain()),


  ];

}


