import 'package:cuidador_app_mobile/Domain/Model/Catalogos/metodo_pago_usuario.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Modules/recharge_balance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../Models/finanzas_controller.dart';

class CreditCards{
  RechargeBalance rechargeBalance = Get.put(RechargeBalance());

  Widget listCards(){
    Get.lazyPut<FinanzasController>(() => FinanzasController());
    FinanzasController finanzasController = Get.find<FinanzasController>();
    return Container(
      height: 205,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: finanzasController.creditCardsList.length + 1,
        itemBuilder: (context, index){
    
          if(index == finanzasController.creditCardsList.length){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: cardAdd(),
            );
          }
          else{
            MetodoPagoUsuario card = finanzasController.creditCardsList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => rechargeBalance.openModalForRecharge(card),
                child: CreditCardUi(
                  cardHolderFullName: card.nombreBeneficiario ?? '',
                  cardNumber: card.numeroTarjeta ?? '',
                  validThru: card.fechaVencimiento ?? '',
                  topLeftColor: Colors.blue,
                  creditCardType: CreditCardType.visa,
                  cardType: CardType.debit,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget cardAdd(){
    return GestureDetector(
      onTap: () => Get.toNamed('/add_credit_card'),
      child: Container(
        width: Get.width * 0.7,
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Icon(Icons.add, color: Colors.white, size: 50,),
          )
        ),
      ),
    );
  }

}