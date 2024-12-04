import 'package:cuidador_app_mobile/Data/Request/Review/review_request.dart';
import 'package:cuidador_app_mobile/Data/Response/Comentarios/comentarios_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/comentarios_model_2.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController{

  TextEditingController reviewController = TextEditingController();

  Rx<ListaContratos> contrato = ListaContratos().obs;
  RxList<ComentariosModel2> comentarios = <ComentariosModel2>[].obs;
  SnackbarUI snackbarUI = SnackbarUI();
  Rx<ComentariosModel2> comentarioEdit = ComentariosModel2().obs;

  ReviewRequest reviewRequest = ReviewRequest();
  ComentariosResponse comentariosResponse = ComentariosResponse();

  RxInt rating = 0.obs;

  RxBool loadingSend = false.obs;
  RxBool loadingComentarios = false.obs;

  @override
  void onInit() async{
    super.onInit();
    try{
      contrato.value = Get.arguments;
      await getComentarios();
    }
    catch(e){
      Get.back();
    }
  }

  Future<void> enviarReview(int calificacion, String comentario) async {
    loadingSend.value = true;
    if(!validateReview()){
      loadingSend.value = false;
      return;
    }
    try
    {
      bool response = await reviewRequest.enviarReview(
        calificacion: rating.value,
        comentario: comentario,
        personaidReceptor: contrato.value.personaCuidador!.idPersona!,
        personaidEmisor: contrato.value.personaCliente!.idPersona!
      );
      loadingSend.value = false;
      if(response){
        Get.toNamed('/completeReview');
      }
    }
    catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      loadingSend.value = false;
    }

  }

  Future<void> getComentarios() async {
    loadingComentarios.value = true;
    try
    {
      comentarios.assignAll(await comentariosResponse.getComentarios(contrato.value.personaCuidador!.idPersona!));
      comentarios.assignAll(comentarios.where((element) => element.personaEmisorid == contrato.value.personaCliente!.idPersona).toList());
      comentarios.refresh();
      loadingComentarios.value = false;
    }
    catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      loadingComentarios.value = false;
    }
  }

  Future<void> actualizarComentario(String comentario) async {
    loadingSend.value = true;
    try
    {
      bool response = await reviewRequest.actualizarComentario(
        idComentario: comentarioEdit.value.idComentarios!,
        calificacion: rating.value,
        comentario: comentario
      );
      loadingSend.value = false;
      if(response){
        Get.toNamed('/completeReview');
      }
    }
    catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      loadingSend.value = false;
    }
  }

  Future<void> eliminarComentario(int idComentario) async {
    loadingSend.value = true;
    try
    {
      await reviewRequest.eliminarComentario(idComentario);
      loadingSend.value = false;
    }
    catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      loadingSend.value = false;
    }
    finally{
      await getComentarios();
    }
  }

  bool validateReview(){
    if(rating.value == 0){
      snackbarUI.snackbarError('Calificación no seleccionada', 'Selecciona una calificación');
      return false;
    }
    // if(reviewController.text.isEmpty){
    //   snackbarUI.snackbarError('Comentario vacío', 'Escribe un comentario');
    //   return false;
    // }
    return true;
  }



}