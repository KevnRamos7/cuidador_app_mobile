
import 'package:cuidador_app_mobile/Domain/Utilities/colors_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Domain/Utilities/route.dart';

void main() async{
  runApp(const MyApp());
  await GetStorage.init();

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    ThemeData.dark();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Cuidador",
      debugShowCheckedModeBanner: false,
      initialRoute: '/list_contratos', 
      getPages: Routes.routes, // Rutas de la aplicacion
      theme: ColorsThemeData().adultoMayorThemeData, // Cambiará dependiendo del valor recolectado del localstorage
      navigatorKey: Get.key,
      defaultTransition: Transition.cupertino, // Animacion de pantalla a pantalla, cambiar de ser necesario
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')], // Idiomas soportados
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  } 
}