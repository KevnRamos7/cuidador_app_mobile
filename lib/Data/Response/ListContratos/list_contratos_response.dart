import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:get/get.dart';

class ListContratosResponse extends GetConnect{

  Future<List<ListaContratos>> getListaContratos() async{
    try
    {
      final response = await get('https://mocki.io/v1/ca2a29f7-6dc2-4e8f-bfd7-e048c931318e');
      if(response.status.hasError)
      {
        return Future.error('Error al obtener la lista de contratos');
      }
      else
      {
        List<ListaContratos> contratos = [];
        for(dynamic contrato in response.body)
        {
          contratos.add(ListaContratos.fromJson(contrato));
        }
        return contratos;
      }
    }
    catch(e)
    {
      return Future.error(e);
    }
  }

}