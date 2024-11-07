import 'package:get/get.dart';

import '../../../Domain/Utilities/connection_string.dart';

class ProgressContractRequest extends GetConnect {
  
  Future<bool> cambiarEstatusContrato(int idContrato, int idEstatus) async{

    try
    {

      Response response = await post('${ConnectionString.connectionString}ContratoItem/cambiarEstatusContratoItem', 
      {
        'id_contrato_item': idContrato,
        'id_estatus': idEstatus
      });

      return response.status.hasError ? false : true;
    }
    catch(e)
    {
      Future.error(e);
      return false;
    }

  }

  Future<bool> cambiarEstatusTarea(int idTarea, int idEstatus) async{
    try
    {
      
      Response response = await post('${ConnectionString.connectionString}cambiarEstatusTarea', {
        'id1': idTarea,
        'id2': idEstatus
      });

      return response.statusCode == 200;
    }
    catch(e)
    {
      return false;
    }
  }

}