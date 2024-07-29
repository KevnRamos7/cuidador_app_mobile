import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCuidadorMain extends StatelessWidget {
  const ProfileCuidadorMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.back, color: Colors.grey[800], size: 25,)),
        centerTitle: true,
        title: const Text('Cuidador', style: TextStyle(color: Colors.grey, fontSize: 17),),
      ),
      body: _summaryProfile(),
    );
  }

  Widget _summaryProfile(){
    return SizedBox(
      height: Get.height * 0.3,
      width: Get.width * 0.95,
      child: Column(
        children: [
          Image.asset('assets/img/testing/profile_image_test.png', height: Get.height * 0.2),
          const Text('Número de Cuidados', style: TextStyle(color: Colors.grey, fontSize: 15),),

        ],
      ),
    );
  }


}