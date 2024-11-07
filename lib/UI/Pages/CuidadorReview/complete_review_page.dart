import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteReviewPage extends StatelessWidget {
  const CompleteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/img/reviews/topComponentReview.png', 
              width: 300, 
              height: 300
            ),
          ),

          Column(
            children: [
              const Text('¡Gracias por tu reseña! 🫂😁', 
                style: TextStyle(
                  color: Color(0xFF818181),
                  fontSize: 20,
                  fontFamily: 'Anek Malayalam',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: Get.width  * 0.8,
                child: const Text('Tu opinión es muy importante para nosotros, gracias por tomarte el tiempo de calificar tu experiencia.', 
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Anek Malayalam',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ), textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/img/reviews/bottomComponentReview.png', 
              width: 300, 
              height: 300
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.05),
                width: Get.width * 0.5,
                height: Get.height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 7, 74, 89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    Get.offNamedUntil('/list_contratos', (route) => false);
                  },
                  child: const Text('Volver', style: TextStyle(
                    color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Anek Malayalam',
                      fontWeight: FontWeight.w500,
                      height: 0,
                  )),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}