import 'package:cuidador_app_mobile/Domain/Model/Feedback/feedback_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class FeedbackRequest extends GetConnect{

SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> insertFeedback(FeedbackModel model) async{

    try{

      final response = await post('${ConnectionString.connectionString}Feedback/insert', 
        {
          "usuarioIdRemitente": 6, //model.usuarioRemitente,
          "categoria": model.categoria,
          "cuerpo": model.cuerpo,
          "usuarioRegistro": 6, //model.usuarioRemitente,
          "fechaRegistro": model.fecha
        }
      );

      return response.status.hasError ? false : true;

    }
    catch(e){
      snackbarUI.snackbarError('Error en la solicitud', 'Error en la solicitud');
      return false;
    }

  }

}