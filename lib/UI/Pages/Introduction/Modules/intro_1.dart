import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Introduction{

  RxInt index = 0.obs;
  PageController pageController = PageController();
  //Hace Falta reemplazar los text por un textAutoSize

  late List<Widget> introductions = [
    formatIntroduction("assets/img/introductions/logotipo.png", "", "Conecta con cuidadores confiables para una atención personalizada.", 0),
    formatIntroduction("assets/img/introductions/logotipo.png", "¿Como Funciona?", "Solicita cuidadores calificados en tu área, monitorea su ubicación en tiempo real y realiza pagos seguros a través de nuestra plataforma, todo con un solo clic", 1),
    formatIntroduction("assets/img/introductions/logotipo.png", "Seguridad y Confianza", "Todos nuestros cuidadores pasan por un riguroso proceso de verificación y entrevistas.", 2),
    registerIntroduction(3),
    pantallaFinal()
  ];

  Widget pageView(){
    return SizedBox(
      height: Get.height * 0.9,
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

  Widget registerIntroduction(int indice){
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: Get.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Es Muy Facil Registrate!'
                , style: GoogleFonts.anekMalayalam(
                  fontSize: 40, 
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                  )
                  , textAlign: TextAlign.center,
                ),
                
                Text('Solo sigue los siguientes pasos'
                , style: GoogleFonts.anekMalayalam(
                  fontSize: 15, 
                  fontWeight: FontWeight.w300,
                  color: Colors.grey
                  )
                  , textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(
            height: Get.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.1,
                        child: Image.asset('assets/img/introductions/websiteIcon.png')),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text('Visita nuestra pagina web', style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey)))
                    ],
                  ),
                ),
                
                SizedBox(
                  width: Get.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.1,
                        child: Image.asset('assets/img/introductions/formIcon.png')),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text('Inicia tu proceso de registro', style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey)
                        , textAlign: TextAlign.start,),
                      )
                    ],
                  ),
                ),
                
                SizedBox(
                  width: Get.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.1,
                        child: Image.asset('assets/img/introductions/docIcon.png')),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text('Ten lista tu documentación', style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey)))
                    ],
                  ),
                ),
                
                SizedBox(
                  width: Get.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.1,
                        child: Image.asset('assets/img/introductions/loadingIcon.png')),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text('Espera a ser aceptado', style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey)))
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: Get.height * 0.05),
            height: Get.height * 0.05,
            child: Obx(()=>
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(introductions.length, (i) {
                  return Icon(
                    Icons.circle,
                    size: 10,
                    color: i == index.value ? Colors.blueGrey : Colors.grey,
                  ).marginOnly(left: 4, right: 4);
                }),
              ),
            )
          ),

          SizedBox(
            height: Get.height * 0.1,
            child: CupertinoButton(
            child: Text('Omitir', style: GoogleFonts.anekMalayalam(fontWeight: FontWeight.w200, fontSize: 15, decoration: TextDecoration.underline),), 
            onPressed: () => Get.offNamedUntil('/login', (route) => false)
            ),
          )

        ],
      ),
    );
  }

  Widget formatIntroduction(String rutaImagen, String titulo, String descripcion, int indice){
    return SizedBox(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(rutaImagen, height: 250, width: 250,),
            ],
          )// Imagen de cada introduccion
          
          , Container(
            margin: EdgeInsets.only(top: Get.height * 0.05),
            height: MediaQuery.of(Get.context!).size.height * 0.15,
            width: Get.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titulo, style: GoogleFonts.anekMalayalam(fontSize: 25, fontWeight: FontWeight.bold))
                , Text(descripcion, style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
              ],
            ),
          )

          , Container(
            margin: EdgeInsets.only(top: Get.height * 0.05),
            height: Get.height * 0.05,
            child: Obx(()=>
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(introductions.length, (i) {
                  return Icon(
                    Icons.circle,
                    size: 10,
                    color: i == index.value ? Colors.blueGrey : Colors.grey,
                  ).marginOnly(left: 4, right: 4);
                }),
              ),
            )
          ),

          SizedBox(
            height: Get.height * 0.1,
            child: CupertinoButton(
            child: Text('Omitir', style: GoogleFonts.anekMalayalam(fontWeight: FontWeight.w200, fontSize: 15, decoration: TextDecoration.underline),), 
            onPressed: () => Get.offNamedUntil('/login', (route) => false)
            ),
          )

        ],
      ),
    );
  }

  Widget pantallaFinal(){
    return SizedBox(
      height: Get.height * 0.8,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/img/introductions/intro_3.png', height: 250, width: 250,)),
          ),

          SizedBox(
            height: Get.height * 0.3,
            width: Get.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '¡Gracias por unirte a cuidador!', 
                  style: GoogleFonts.anekMalayalam(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: Get.height * 0.05,),
                Text(
                  'Tu plataforma confiable para conectar con cuidadores calificados y brindar la mejor atención a tus seres queridos.', 
                  style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
            
              ],
            ),
          ),

          SizedBox(
            height: Get.height * 0.15,
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A7FCF),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    onPressed: (){Get.offNamedUntil('/login', (route) => false);}, 
                    child: Text('Iniciar Sesión', style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    onPressed: (){}, 
                    child: Text('Registrate!', style: GoogleFonts.anekMalayalam(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),)
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }

}