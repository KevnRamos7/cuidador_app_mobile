import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Models/finanzas_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Modules/bank_account.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Modules/credit_cards.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Shared/header_pay.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Shared/transactions_recent.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/screens_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Shared/BottomNavigation/bottom_navigation_main.dart';

class FinanzasPage extends StatelessWidget {
  HeaderPay hearderPay = Get.put(HeaderPay());
  CreditCards creditCards = Get.put(CreditCards());
  BankAccount bankAccount = Get.put(BankAccount());
  TransactionsRecent transactionsRecent = Get.put(TransactionsRecent());
  FinanzasController con = Get.put(FinanzasController());
  ScreenStates states = Get.put(ScreenStates());

  @override
  Widget build(BuildContext context) {
    dynamic usuario = GetStorage().read('usuario');
    return Scaffold(
      body: Obx(()=>
      con.loadingScreen.value == true ? states.loadingScreen() :
        Stack(
          children: [
            hearderPay.headerPay(
              usuario['tipoUsuarioid'] == 1 ? con.finanzasCuidador.value.saldoActual ?? 0 : (con.finanzasCliente.value.saldoActual ?? 0), 
              usuario['tipoUsuarioid'] == 1 ? con.finanzasCuidador.value.saldoRetirado : null
            ),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.35),
              child: Column(
                children: [
                 usuario['tipoUsuarioid'] == 1 ? 
                  bankAccount.cardBackAccount()
                 : creditCards.listCards(),
                  transactionsRecent.transactions()
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  }
}