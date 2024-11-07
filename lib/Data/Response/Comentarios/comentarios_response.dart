import 'package:cuidador_app_mobile/Domain/Model/Catalogos/comentarios_model_2.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/comentarios_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class ComentariosResponse extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<List<ComentariosModel2>> getComentarios (int idPersona) async {

    try
    {

      Response response = await get('${ConnectionString.connectionString}/comentarios/$idPersona');

      switch(response.statusCode){
        case 200:
          List<ComentariosModel2> comentarios = [];
          for(var item in response.body){
            comentarios.add(ComentariosModel2.fromJson(item));
          }
          return comentarios;
        case 400:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al obtener la lista de comentarios');
        case 500:
          snackbarUI.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al obtener la lista de comentarios');
        default:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return [];

      }

    }
    catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return [];
    }

  }


}