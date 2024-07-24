
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmacionContPage extends StatelessWidget {
  const ConfirmacionContPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmación', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),),
      body:  Container(
        margin: EdgeInsets.only(top: Get.height * 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.3,
                child: Image.asset('assets/img/shared/confirmacion_cont.png'),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: Get.width * 0.7,
                child:  Text('TU SOLICITUD HA SIDO ENVIADA CON EXITO',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[800], fontSize: 30, fontWeight: FontWeight.w500),),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: Get.width * 0.7,
                child: const Text('Te notificaremos en cuanto recibamos una respuesta de tu cuidador.', 
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),)),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.3,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 19, 68, 108),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Volver', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(width: 20,),
            IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.share), color: const Color.fromARGB(255, 19, 68, 108), iconSize: 30,)
          ],
        ),
      ),
    );
  }
}