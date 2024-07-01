import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Introduction extends StatefulWidget{
  const Introduction({super.key});

  @override
  IntroductionState createState() => IntroductionState();
}

class IntroductionState extends State<Introduction>{
  

  RxInt index = 0.obs;
  PageController pageController = PageController();
  //Hace Falta reemplazar los text por un textAutoSize

  late List<Widget> introductions = [
    formatIntroduction("assets/images/introduction1.png", "Bienvenido a Cuidador", "Cuidador es una aplicación que te ayudará a cuidar a tus seres queridos de una manera más eficiente y segura", 0),
    formatIntroduction("assets/images/introduction2.png", "Cuidador de Adulto Mayor", "Cuidador es una aplicación que te ayudará a cuidar a tus seres queridos de una manera más eficiente y segura", 1),
    formatIntroduction("assets/images/introduction3.png", "Cuidador de Niños", "Cuidador es una aplicación que te ayudará a cuidar a tus seres queridos de una manera más eficiente y segura", 2),
    formatIntroduction("assets/images/introduction4.png", "Cuidador de Mascotas", "Cuidador es una aplicación que te ayudará a cuidar a tus seres queridos de una manera más eficiente y segura", 3),
  ];

  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (page)=> index.value = page,
        itemCount: introductions.length,
        itemBuilder: (context, index){
          return introductions[index];
        },
      )
    );
  }

  Widget formatIntroduction(String rutaImagen, String titulo, String descripcion, int indice){
    return SizedBox(
      child: Column(
        children: [
          Image.asset(rutaImagen)// Imagen de cada introduccion
          , Text(titulo, style: GoogleFonts.anekMalayalam(fontSize: 20, fontWeight: FontWeight.bold))
          , Text(descripcion)
          , SizedBox(
            child: Obx(()=>
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(introductions.length, (i) {
                  return Icon(
                    Icons.circle,
                    color: i == index.value ? Colors.blueGrey : Colors.grey,
                  ).marginOnly(left: 4, right: 4);
                }),
              ),
            )
          )
        ],
      ),
    );
  }

}