import 'package:cuidador_app_mobile/UI/Pages/Introduction/Modules/intro_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionPageMain extends StatelessWidget {
  Introduction intro = Get.put(Introduction());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Image.asset('assets/img/introductions/isotipo.png', width: 50, height: 50,)),
      ),
      body: intro.pageView(),
    );
  }
}