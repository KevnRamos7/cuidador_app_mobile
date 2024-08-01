import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalComponents{

  void showModal(Widget content){
    showBarModalBottomSheet(
      context: Get.context!, 
      builder: (context){
        return Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.9,
          child: content,
        );
      }
    );
  }

  void showConfirmCancel({required Function() onConfirm, required Function() onCancel, required String message}) {
    showBarModalBottomSheet(
      context: Get.context!, 
      builder: (context){
        return Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.2,
          child: Column(
            children: [
              Text(message, style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    onPressed: (){},
                    child: const Text('Cancelar', style: TextStyle(color: Colors.grey),),
                  ),
                  CupertinoButton(
                    onPressed: (){},
                    child: const Text('Aceptar', style: TextStyle(color: Colors.green),),
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }

}