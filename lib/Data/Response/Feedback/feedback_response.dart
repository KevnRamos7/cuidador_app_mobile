import 'package:cuidador_app_mobile/Domain/Model/Feedback/feedback_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class FeedbackResponse extends GetConnect{

SnackbarUI snackbarUI = SnackbarUI();

  Future<List<FeedbackModel>> getFeedBack() async{

    try
    {
      final response = await get('${ConnectionString.connectionString}Feedback/getFeedback');

      switch(response.statusCode){
        case 200:
          List<FeedbackModel> feedbackList = [];
          if (response.body == null){
            snackbarUI.snackbarInfo('No se encontraron solicitudes', 'No se encontraron solicitudes');
            return [];
          }
          for (var item in response.body){
            feedbackList.add(FeedbackModel.fromJson(item));
          }
          return feedbackList;
        case 404:
          snackbarUI.snackbarError('No se encontraron solicitudes', 'No se encontraron solicitudes');
          return [];
        case 500:
          snackbarUI.snackbarError('Error en el servidor', 'Error en el servidor');
          return [];
        default:
          return [];
      }

    }
    catch(e){
      snackbarUI.snackbarError('Error en la solicitud', 'Error en la solicitud');
      return [];
    }

  }

}