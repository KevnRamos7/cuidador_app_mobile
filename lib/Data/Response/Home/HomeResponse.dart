import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Objects/dasboard.dart';

class HomeResponse extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<List<UsuarioModel>> getFeedPage() async{
    List<UsuarioModel> usuarios = [];
    try
    {
      // final response = await get('https://mocki.io/v1/4d570bfa-2969-4b58-8e95-0d78db7eb969');
      final response = await get('${ConnectionString.connectionString}Usuario/verCuidadores');
      
      for(var item in response.body){
        usuarios.add(UsuarioModel.fromJson(item));
      }

    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido un Error!', e.toString());
    }
    return usuarios;
  }

  Future<Dasboard> getDashboard() async{
    dynamic usuario = GetStorage().read('usuario');
    Dasboard dashboard = Dasboard();
    try{
      Response response = await get('${ConnectionString.connectionString}Usuario/dashboardCuidador/${usuario['idUsuario']}');
      
      if(response.status.hasError){
        // snackbarUI.snackbarError('Ha Ocurrido un Error!', response.statusText!);
        return Dasboard();
      }
      else{
        dashboard = Dasboard.fromJson(response.body);
        return dashboard;
      }

    }
    catch(e){
      // snackbarUI.snackbarError('Ha Ocurrido un Error!', e.toString());
      return Dasboard();
    }
  }

  

}