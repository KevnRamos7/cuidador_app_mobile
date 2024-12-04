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
      final response = await get('${ConnectionString.connectionString}ContratoItem/fechasOcupadasCuidador/$idpersona');
      
      switch(response.statusCode)
      {
        case 200:
          if(response.body.isNotEmpty)
          {
            List<dynamic> data = response.body;
            contratos = data.map((e) => ContratoItemModel.fromJson(e)).toList();
          }
        case 500:
          snackbarUI.snackbarError('Ha Ocurrido un Error!', 'Error en el servidor');
          break;
      }
    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido un Error!', e.toString());
    }
    return contratos.obs;
  }

}