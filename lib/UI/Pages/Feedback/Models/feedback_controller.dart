// import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Data/Request/Feedback/feedback_request.dart';
import 'package:cuidador_app_mobile/Data/Response/Feedback/feedback_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Feedback/feedback_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FeedbackController extends GetxController{

  
  RxList<FeedbackModel> feedbackList = <FeedbackModel>[].obs;
  List<String> categorias = ['Tiempos de carga', 'Nueva Funcionalidad', 'Errores en la aplicación', 'Otro'];
  RxBool isLoading = false.obs;
  RxBool isLoadingList = false.obs;
  FeedbackResponse feedbackResponse = FeedbackResponse();
  FeedbackRequest feedbackRequest = FeedbackRequest();

  @override
  void onInit() {
    super.onInit();
    _loadFeedbackList();
  }

  Future<void> _loadFeedbackList() async{
    try{
      isLoadingList.value = true;
      feedbackList.value = await feedbackResponse.getFeedBack();
    }
    finally{
      isLoadingList.value = false;
    }
  }

  Future<void> addFeedback(FeedbackModel feedback) async{
    try{
      isLoading.value = true;
      // feedback.usuarioRemitente = GetStorage().read('usuario')['idUsuario'];
      bool result = await feedbackRequest.insertFeedback(feedback);
      if(result){
        _loadFeedbackList();
      }
    }
    finally{
      isLoading.value = false;
    }
  }

}