import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class HomeResponse extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<List<UsuarioModel>> getFeedPage() async{
    List<UsuarioModel> usuarios = [];
    try
    {
      final response = await get('https://mocki.io/v1/af24dd78-00dc-4885-93e5-2b5bccab217b');
      
      for(var item in response.body){
        usuarios.add(UsuarioModel.fromJson(item));
      }

    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido un Error!', e.toString());
      print(e.toString());
    }
    return usuarios;
  }

  

}