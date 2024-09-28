import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

import '../../../Domain/Utilities/connection_string.dart';

class LoginResponse extends GetConnect{

  SnackbarUI snackbarDark = SnackbarUI();

  Future<UsuarioModel> login(String usuario, String contrasenia) async {
    try
    {
      Response response = await post('${ConnectionString.connectionString}Usuario/login', {
        'usuario': usuario,
        'contrasenia': contrasenia
      }, headers: {
        'Content-Type': 'application/json'
      });

      switch(response.statusCode){

          case 200:
            UsuarioModel usuarioModel = UsuarioModel.fromJson(response.body);
            return usuarioModel;
            
          case 404: 
            snackbarDark.snackbarError('Error Interno del Servidor', '');
            return UsuarioModel();
          
          case 500: 
            snackbarDark.snackbarError('Error Interno del Servidor', '');
            return UsuarioModel();
          
          case 400: 
            snackbarDark.snackbarError('Usuario o contraseña incorrectos', '');
            return UsuarioModel();

          default:
            snackbarDark.snackbarError('Error Interno del Servidor', '');
            return UsuarioModel();

        }

    }
    catch(e)
    {
      snackbarDark.snackbarError('Se ha producido un error dentro de la app', '');
      return UsuarioModel();
    }
  }

}