
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMenuProfile{

  MyProfileClienteController con = Get.put(MyProfileClienteController());

  Widget listaMenus(){
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Mi Perfil', 
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 129, 128, 128)
                  ), 
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20,),
          _itemMenu2('Datos Personales', (){
            con.update(['dataPersonal']);
            con.changeIndex(1);
          }),
          _itemMenu2('Domicilio', () async {
            await con.getDomicilio();
            con.update(['domicilio']);
            con.changeIndex(2);
          }),
          _itemMenu2('Datos Médicos', () async {
            await con.getDatosMedicos();
            con.update(['datosMedicos']);
            con.changeIndex(3);
          }),
          _itemMenu2('Padecimientos', () async {
            await con.getPadecimientos();
            con.update(['padecimientos']);
            con.changeIndex(4);
          }),
          // _itemMenu2('Horarios', (){}),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(color: Colors.grey),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Configuración', 
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 129, 128, 128)
                  ), 
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),

          _itemMenu2('Cambiar Contraseña', (){
            _changePassword();
          }),
          _itemMenu2('Desbloqueo Biometrico', (){}),
          _itemMenu2('Cerrar Sesión', (){
            Get.offNamedUntil('/login', (route) => false);
          }),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(color: Colors.grey),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Otros Menús', 
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 129, 128, 128)
                  ), 
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),

          _itemMenu2('Feedback', (){
            Get.toNamed('/feedback');
          }),
          _itemMenu2('Notificaciones', (){}),

          const SizedBox(height: 20,),

        ],
      ),
    ); 
  }

  Widget _itemMenu2(String nombreMenu, Function() onTap){
  return Container(
    // height: ,
    color: Colors.white,
    child: ListTile(
      hoverColor: Colors.black,
      title: Text(nombreMenu, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey[800]),
    ),
  );
}

  Future<void> _changePassword() async{
    TextEditingController passwordActual = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    SnackbarUI snackbar = SnackbarUI();
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
              controller: passwordActual,
              decoration: InputDecoration(
                labelText: 'Contraseña Actual',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: newPassword,
              decoration: InputDecoration(
                labelText: 'Nueva Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: confirmPassword,
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
                onPressed: (){
                  
                  if(con.currentUser.value.contrasena == passwordActual.text){
                    if(newPassword.text == confirmPassword.text){
                      Get.back();
                      con.updatePassword(newPassword.text);
                    }
                    else{
                      snackbar.snackbarInfo('Las contraseñas no coinciden', 'Por favor, verifica que las contraseñas sean iguales');
                    }
                  }
                  else{
                    snackbar.snackbarInfo('Contraseña incorrecta', 'Por favor, verifica tu contraseña actual');
                  }

                },
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