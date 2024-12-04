import 'package:cuidador_app_mobile/Domain/Model/Catalogos/padecimientos_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/datos_medicos_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/domicilio_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class MyProfileResponse extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<UsuarioModel> getMyProfile(int personaId) async {
    
    try
    {
      final response = await get('${ConnectionString.connectionString}MyProfile/getProfile/$personaId');
     
      switch(response.statusCode){
        case 200:
          return UsuarioModel.fromJson(response.body);
        default:
          snackbarUI.snackbarError('Error', 'Error al obtener el perfil');
          return UsuarioModel();
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return UsuarioModel();
    }

  }

  Future<DomicilioModel> getDomicilio(int personaId) async {
      try
      {
        final response = await get('${ConnectionString.connectionString}MyProfile/getDomicilio/$personaId');
      
        switch(response.statusCode){
          case 200:
            return DomicilioModel.fromJson(response.body);
          default:
            snackbarUI.snackbarError('Error', 'Error al obtener el domicilio');
            return DomicilioModel();
        }
  
      }
      catch(e){
        snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
        return DomicilioModel();
      }
  }

  Future<DatosMedicosModel> getDatosMedicos(int personaId) async {
    try
    {
      final response = await get('${ConnectionString.connectionString}MyProfile/getDatosMedicos/$personaId');
    
      switch(response.statusCode){
        case 200:
          return DatosMedicosModel.fromJson(response.body);
        default:
          snackbarUI.snackbarError('Error', 'Error al obtener los datos médicos');
          return DatosMedicosModel();
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return DatosMedicosModel();
    }
  }

  Future<List<PadecimientosModel>> getPadecimientos(int personaId) async {
    try
    {
      final response = await get('${ConnectionString.connectionString}MyProfile/getPadecimientos/$personaId');
    
      switch(response.statusCode){
        case 200:
          return (response.body as List).map((e) => PadecimientosModel.fromJson(e)).toList();
        default:
          snackbarUI.snackbarError('Error', 'Error al obtener los padecimientos');
          return [];
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return [];
    }
  }

}