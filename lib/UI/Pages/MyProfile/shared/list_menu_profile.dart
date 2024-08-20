
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMenuProfile{

  MyProfileClienteController con = Get.put(MyProfileClienteController());

  late List<ItemsLista> itemsCuidador = [
    ItemsLista(nombreMenu: 'Datos Personales', icono: CupertinoIcons.person_fill, onTap: (){con.changeIndex(1);}, trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800])),
    ItemsLista(nombreMenu: 'Domicilio', icono: CupertinoIcons.house_alt_fill, onTap: (){con.changeIndex(2);}, trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800])),
    ItemsLista(nombreMenu: 'Cambiar Contraseña', icono: CupertinoIcons.lock_circle_fill, onTap: (){_changePassword();}, trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800])),
    ItemsLista(nombreMenu: 'Datos Medicos', icono: CupertinoIcons.heart_circle_fill, onTap: (){con.changeIndex(3);}, trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800])),
    ItemsLista(nombreMenu: 'Padecimientos', icono: CupertinoIcons.bandage_fill, onTap: (){con.changeIndex(4);}, trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800])),
    // ItemsLista(nombreMenu: 'Comentarios', icono: CupertinoIcons.chat_bubble_2_fill, onTap: (){}, trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800])),
    // ItemsLista(nombreMenu: 'Inicio rapido', icono: CupertinoIcons.bolt_fill, onTap: null, trailing: SizedBox(width: 15, height: 15, child: Obx(()=> CupertinoSwitch(value: con.inicioRapido.value, onChanged: (value){con.changeInicioRapido(value);})))),
  ];

  Widget listaMenus(){
    return Expanded(
      child: ListView.builder(
        itemCount: itemsCuidador.length,
        itemBuilder: (context, builder){
          return _itemMenu(itemsCuidador[builder].nombreMenu, itemsCuidador[builder].icono, itemsCuidador[builder].onTap!, itemsCuidador[builder].trailing);
        },
      ),
    ); 
  }

  Widget _itemMenu(String nombreMenu, IconData icono, Function() onTap, Widget? trailing){
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    child: Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
      //   ),
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(nombreMenu, style: TextStyle(color: Colors.grey[600]),),
        leading: Icon(icono, size: 30,color: Colors.grey[700],),
        trailing: trailing,
        onTap: onTap,
      ),
    ),
  );
}

  Future<void> _changePassword() async{
    return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: Get.height * 0.45,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Cambiar Contraseña', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contraseña Actual',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nueva Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: Get.width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF395886),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
                onPressed: (){},
                child: const Text('Cambiar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
      )
    );
  }


}

class ItemsLista{
  String nombreMenu;
  IconData icono;
  Function()? onTap;
  Widget? trailing;

  ItemsLista({required this.nombreMenu, required this.icono, this.onTap, this.trailing});
}