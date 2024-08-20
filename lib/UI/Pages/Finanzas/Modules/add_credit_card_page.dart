
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../../../Domain/Model/Catalogos/metodo_pago_usuario.dart';
import '../Models/finanzas_controller.dart';

class AddCreditCardPage extends StatelessWidget {
  const AddCreditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return FocusScope(
      node: FocusScopeNode(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Agregar Tarjeta', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w400),),
              centerTitle: true,
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: SafeArea(
                  child: Obx(()=>
                    Column(
                      children: [
                        CreditCardWidget(
                          cardNumber: con.numeroTarjeta.value,
                          expiryDate: con.fechaVencimiento.value,
                          cardHolderName: con.nombreBeneficiario.value,
                          cvvCode: con.cvv.value,
                          showBackView: false,
                          onCreditCardWidgetChange: (CreditCardBrand brand) {},
                          enableFloatingCard: true,
                          floatingConfig: const FloatingConfig(
                            isGlareEnabled: true,
                            isShadowEnabled: true,
                            shadowConfig: FloatingShadowConfig(),
                          ),
                          isHolderNameVisible: true,
                          isSwipeGestureEnabled: true,
                          cardBgColor: Colors.blueGrey[900]!,
                          animationDuration: Durations.long1,
                          labelCardHolder: 'Nombre del Titular',
                          labelExpiredDate: 'MM/AA',
                        ),
                        const SizedBox(height: 20,),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CreditCardForm(
                                  cardNumber: con.numeroTarjeta.value, 
                                  expiryDate: con.fechaVencimiento.value, 
                                  cardHolderName: con.nombreBeneficiario.value,
                                  dateValidationMessage: 'Fecha Invalida',
                                  cvvCode: con.cvv.value, 
                                  onCreditCardModelChange: (CreditCardModel creditCardModel) {
                                    con.numeroTarjeta.value = creditCardModel.cardNumber;
                                    con.fechaVencimiento.value = creditCardModel.expiryDate;
                                    con.nombreBeneficiario.value = creditCardModel.cardHolderName;
                                    con.cvv.value = creditCardModel.cvvCode;
                                  }, 
                                  formKey: formKey
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: Get.width * 0.7,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: con.loadingAddCard.value == true ? Colors.grey : Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: (){
                              if(formKey.currentState!.validate() || con.loadingAddCard.value == false){
                                con.addTarjeta(MetodoPagoUsuario(
                                  nombreBeneficiario: con.nombreBeneficiario.value,
                                  numeroTarjeta: con.numeroTarjeta.value,
                                  fechaVencimiento: con.fechaVencimiento.value,
                                  cvv: con.cvv.value
                                ));
                              }
                            },
                            child: 
                            con.loadingAddCard.value == true ?
                              const CupertinoActivityIndicator() :
                              const Text('Agregar Tarjeta', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.2,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          
        ),
      ),
    );
  }
}