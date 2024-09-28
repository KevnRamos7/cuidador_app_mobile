import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
// import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/contrato_item_list.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class ContratoResponse extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<RxList<ContratoItemModel>> getFechasNoDisponibles(int idpersona) async{
    List<ContratoItemModel> contratos = [];
    try
    {
      final response = await get('${ConnectionString.connectionString}api/ContratoItem/fechasOcupadasCuidador/$idpersona');
      
      for(var item in response.body){
        contratos.add(ContratoItemModel.fromJson(item));
        print(response.body);
      }

    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido un Error!', e.toString());
    }
    return contratos.obs;
  }

}