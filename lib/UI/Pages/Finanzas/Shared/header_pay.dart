import 'package:cuidador_app_mobile/Domain/Utilities/format_money_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderPay{

  FormatMoneyNumber formatMoneyNumber = FormatMoneyNumber();

  Widget headerPay(double saldoActual, double? secondSaldo){
    return Container(
      height: Get.height * 0.45,
      width: Get.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.96, 0.29),
          end: Alignment(-0.96, -0.29),
          colors: [Color(0xFFEBFCFF), Color(0x4C5CCEFF)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
        
            const Text('Saldo actual', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),),
            const SizedBox(height: 10,),  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('\$', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                Text(formatMoneyNumber.formatCurrencyInMXN(saldoActual), style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
              ],
            ),  

            secondSaldo == null ? const SizedBox()
            : Container(
              margin: EdgeInsets.only(top: Get.height * 0.05),
              child: Column(
                children: [
                  const Text('Saldo Retirado', style: TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.w200),),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('\$', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 10,),
                      Text(formatMoneyNumber.formatCurrencyInMXN(secondSaldo), style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w200),),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}