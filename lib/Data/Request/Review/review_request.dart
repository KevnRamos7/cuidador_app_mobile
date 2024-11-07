import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

import '../../../Domain/Utilities/connection_string.dart';

class ReviewRequest extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> enviarReview({required int calificacion, required String comentario, required int personaidReceptor, required int personaidEmisor}) async{
    try
    {
      
      Response response = await post('${ConnectionString.connectionString}Comentarios/agregarComentario', {
        'idPersonaReceptor': personaidReceptor,
        'idPersonaEmisor': personaidEmisor,
        'calificacion': calificacion,
        'comentario': comentario
      });
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Comentario enviado correctamente', '');
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

    }catch(e)
    {
      return false;
    }
  }

  Future<bool> actualizarComentario({
    required int idComentario,
    required int calificacion,
    required String comentario,
  }) async {

    try 
    {

      Response response = await post('${ConnectionString.connectionString}Comentarios/actualizarComentario', {
        'idComentario': idComentario,
        'calificacion': calificacion,
        'comentario': comentario
      });

      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Comentario actualizado correctamente', '');
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

    } catch (e) {
      return false;

    }

  }

  Future<bool> eliminarComentario(int idComentario) async {

    try 
    {

      Response response = await delete('${ConnectionString.connectionString}Comentarios/$idComentario');

      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Comentario eliminado correctamente', '');
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

    } catch (e) {
      return false;

    }

  }

}