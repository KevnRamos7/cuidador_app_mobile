import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class ListaContratoRequest extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> cambiarEstatusContrato(int idContrato, int idEstatus) async{

    try{

      Response response = await post('${ConnectionString.connectionString}ContratoItem/cambiarEstatusContratoItem', 
      {
        'idContratoItem': idContrato,
        'idEstatus': idEstatus
      });

      switch(response.statusCode){
        case 200:
          return true;
        case 400:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
        case 500:
          snackbarUI.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return false;
        default:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
      }
    }catch(e){
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return false;
    }

  }

  Future<bool> cambiarEstatusTarea(int idTarea, int idEstatus) async{
    try{
      Response response = await post('${ConnectionString.connectionString}AdminTareas/cambiarEstatusTarea', {
        'id1': idTarea,
        'id2': idEstatus
      });
      
      switch(response.statusCode){
        case 200:
          return true;
        case 400:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
        case 500:
          snackbarUI.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return false;
        default:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
      }

    }
    catch(e){
      return false;
    }
  }

}