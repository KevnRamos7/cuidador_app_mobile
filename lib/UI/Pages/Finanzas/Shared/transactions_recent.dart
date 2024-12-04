import 'package:cuidador_app_mobile/Domain/Model/Catalogos/TransaccionesSaldo.dart';
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/movimiento_cuenta.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/format_money_number.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Models/finanzas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TransactionsRecent{

  FormatMoneyNumber formatMoneyNumber = FormatMoneyNumber();
  LetterDates letterDates = LetterDates();

  Widget transactions(){
    dynamic usuario = GetStorage().read('usuario');
    Get.lazyPut<FinanzasController>(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();
    return SizedBox(
      height: Get.height * 0.3,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
            height: Get.height * 0.05,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Transacciones recientes', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),),
              ],
            )),

          usuario['tipoUsuarioid'] == 1 ?
          
            Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: con.finanzasCuidador.value.movimientos?.length ?? 0,
              itemBuilder: (context, index) {
              List<MovimientoCuenta>? movimientos = con.finanzasCuidador.value.movimientos;
              movimientos?.sort((a, b) => b.idMovimientoCuenta!.compareTo(a.idMovimientoCuenta!)); // Ordenar por id descendientemente
              MovimientoCuenta? mov = movimientos?[index];
              return _itemMov(mov!.tipoMovimiento ?? '', mov.conceptoMovimiento ?? '', letterDates.formatearFecha(mov.fechaMovimiento.toString()) , mov.importeMovimiento ?? 0);
              },
            ),
            )
          :

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: con.finanzasCliente.value.transacciones?.length ?? 0,
              itemBuilder: (context, index) {
                Transaccionessaldo? mov = con.finanzasCliente.value.transacciones?[index];
                return _itemMov(mov!.tipoMovimiento ?? '', mov.conceptoTransaccion ?? '', letterDates.formatearFecha(mov.fechaTransaccion.toString()) , mov.importeTransaccion ?? 0);
              },
            ),
          )
      
        ],
      ),
    );
  }

  Widget _itemMov(String title, String description, String date, double amount){
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0x4CF1F9FD),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFF6F6F6F)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTile(
        shape: ShapeBorder.lerp(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), 0.5),
        trailing: Text('\$ ${formatMoneyNumber.formatCurrencyInMXN(amount)}', style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.bold),),
        title: Text(title, style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.bold),),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey, height: 0.5,),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height:50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(description, style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.w400),),
                Text(date, style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 13, fontWeight: FontWeight.w400),),
              ],
            )),
        ],
      ),
    );
  }

}