import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
// import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/contrato_item_list.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class ContratoResponse extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<List<ContratoItemModel>> getFechasNoDisponibles() async{
    List<ContratoItemModel> contratos = [];
    try
    {
      final response = await get('https://mocki.io/v1/d8818b56-d647-4acb-84fb-dd1205cd53ee');
      
      for(var item in response.body){
        contratos.add(ContratoItemModel.fromJson(item));
      }

    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido un Error!', e.toString());
    }
    return contratos;
  }

}