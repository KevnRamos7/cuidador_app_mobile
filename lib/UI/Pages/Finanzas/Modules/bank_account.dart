
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/cuenta_bancaria.dart';
import 'package:cuidador_app_mobile/UI/Pages/Finanzas/Models/finanzas_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class BankAccount{

  Widget cardBackAccount(){
    Get.lazyPut<FinanzasController>(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();
    return Container(
      padding: const EdgeInsets.all(10),
      height: 155,
      width: 325,
      decoration: ShapeDecoration(
        color: const Color(0xFF101248),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cuenta Bancaria', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              const Spacer(),
              pullDownButton()
            ],
          ),
    
          Column(
            children: [
              Row(
                children: [
                  Text(con.bankAccount.value.clabeInterbancaria.toString(), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                  const SizedBox(width: 10,),
                  const Text('Clabe', 
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),),
                ],
              ),
              Row(
                children: [
                  Text(con.bankAccount.value.nombreBanco.toString(), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                  const SizedBox(width: 10,),
                  const Text('Banco', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),),
                ],
              ),
            ],
          ),
    
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(con.bankAccount.value.usuario?.persona?.first.nombre ?? '', style: const TextStyle(color: Color.fromARGB(255, 228, 228, 228), fontSize: 13, fontWeight: FontWeight.w400),),
            ],
          ),
        ],
      ),
    );
  }

  PullDownButton pullDownButton(){
    Get.lazyPut<FinanzasController>(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();
    return PullDownButton(
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis, color: Colors.white, size: 15,)
      ),
      itemBuilder: (context) {
        return [
          PullDownMenuItem( //Interactuar con el contrato
            onTap: (){
              _showModalRetirar();
            },
            title: 'Retirar',
            icon: CupertinoIcons.money_dollar,
            iconColor: Colors.green,
          ),
          PullDownMenuItem( //Interactuar con el contrato
            onTap: (){
              _showModalEditar();
            },
            title: 'Editar',
            icon: CupertinoIcons.pencil,
            iconColor: Colors.grey,
          ),
        ];
      },
    );
  }

  Future<void> _showModalEditar(){
    Get.lazyPut<FinanzasController>(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();
    TextEditingController clabe = TextEditingController();
    TextEditingController banco = TextEditingController();
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: Get.height * 0.5,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              children: [
                const Text('Editar Cuenta Bancaria', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const Spacer(),
                GestureDetector(onTap: () => Get.back(), child: const Icon(CupertinoIcons.xmark, color: Colors.grey,))
              ],
            ),

            const SizedBox(height: 20),

            const Text('Ingresa la CLABE interbancaria', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            const SizedBox(height: 20),

            CupertinoTextField(
              textAlign: TextAlign.center,
              placeholder: '000000000000000000',
              keyboardType: TextInputType.number,
              padding: const EdgeInsets.all(10),
              controller: clabe,
            ),

            const SizedBox(height: 20),

            const Text('Ingresa el nombre del banco', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            const SizedBox(height: 20),

            CupertinoTextField(
              textAlign: TextAlign.center,
              placeholder: 'Banco',
              padding: const EdgeInsets.all(10),
              controller: banco,
            ),

            const SizedBox(height: 50),

            Obx(()=>
              SizedBox(
                width: Get.width * 0.7,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if(con.loadingModifyAccount.value == true) return;
                      con.modificarCuentaBancaria(
                        double.parse(clabe.text), banco.text
                      );
                  },
                  label: 
                  con.loadingModifyAccount.value == true ?
                    const CupertinoActivityIndicator(color: Colors.white,) :
                  const Text('Modificar', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              ),
            )

          ],
        ),
      )
    );
  }


  Future<void> _showModalRetirar(){
    Get.lazyPut<FinanzasController>(() => FinanzasController());
    FinanzasController con = Get.find<FinanzasController>();
    TextEditingController monto = TextEditingController();
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: Get.height * 0.4,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              children: [
                const Text('Retirar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const Spacer(),
                GestureDetector(onTap: () => Get.back(), child: const Icon(CupertinoIcons.xmark, color: Colors.grey,))
              ],
            ),

            const SizedBox(height: 20),

            const Text('Ingresa el monto deseado', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            const SizedBox(height: 20),

            CupertinoTextField(
              textAlign: TextAlign.center,
              placeholder: '\$ 0.00',
              keyboardType: TextInputType.number,
              padding: const EdgeInsets.all(10),
              controller: monto,
            ),

            const SizedBox(height: 50),

            Obx(()=>
              SizedBox(
                width: Get.width * 0.7,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if(con.loadingDisposeCash.value == true) return;
                     con.retirarSaldo(double.parse(monto.text));
                  },
                  label: 
                  con.loadingDisposeCash.value == true ?
                    const CupertinoActivityIndicator(color: Colors.white,) :
                  const Text('Retirar', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              ),
            )

          ],
        ),
      )
    );
  }

}