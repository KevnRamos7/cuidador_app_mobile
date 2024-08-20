import 'package:cuidador_app_mobile/Domain/Model/Catalogos/metodo_pago_usuario.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/format_money_number.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Models/finanzas_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:u_credit_card/u_credit_card.dart';

class RechargeBalance{

  Future<void> openModalForRecharge(MetodoPagoUsuario pago){
    FormatMoneyNumber formatMoneyNumber = FormatMoneyNumber();
    RxString cvv = ''.obs;
    Rx<TextEditingController> monto = TextEditingController().obs;

    Get.lazyPut(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();

    return showBarModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Container(
          height: Get.height * 0.8,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const Text('Detalles del Pago', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),

              const Text('Ingresa el monto deseado', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),

              CupertinoTextField(
                controller: monto.value,
                textAlign: TextAlign.center,
                placeholder: formatMoneyNumber.formatCurrencyInMXN(0),
                keyboardType: TextInputType.number,
                padding: const EdgeInsets.all(10),
              ),

              const SizedBox(height: 50),

              const Text('Metodo de pago', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

              const SizedBox(height: 20),

              CreditCardUi(
                cardHolderFullName: pago.nombreBeneficiario ?? '',
                cardNumber: pago.numeroTarjeta ?? '',
                validThru: pago.fechaVencimiento ?? '',
                topLeftColor: Colors.blue,
                creditCardType: CreditCardType.visa,
                cardType: CardType.debit,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: Get.width * 0.2,
                child: CupertinoTextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  placeholder: 'CVV',
                  keyboardType: TextInputType.number,
                  padding: const EdgeInsets.all(10),
                  onChanged: (value) => cvv.value = value,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              SizedBox(height: Get .height * 0.1),
              Obx(()=>
                SizedBox(
                  width: Get.width * 0.8,
                  child: FloatingActionButton.extended(
                    onPressed: (){
                      if(con.loadingAddBankAccount.value == true){
                        return;
                      }
                      con.recargarSaldo(pago, monto.value.text, cvv.value);
                    },
                    label:  
                      con.loadingAddBankAccount.value == true ?
                        const CupertinoActivityIndicator() :
                      const Text('Recargar', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    backgroundColor: con.loadingAddBankAccount.value == true ? Colors.grey : Colors.blueGrey,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  } 

  String fechaCortada(String fecha){

    if(fecha.length <= 5){
      return fecha;
    }

    String mes = fecha.substring(0, 2);
    String anio = fecha.substring(3, 5);
    return '$mes/$anio';
  }

}