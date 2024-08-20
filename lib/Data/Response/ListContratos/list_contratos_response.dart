import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/eventos_contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListContratosResponse extends GetConnect{

  Future<List<ListaContratos>> getListaContratos() async{
    try
    {
      dynamic usuario = GetStorage().read('usuario');
      // final response = await get('${ConnectionString.connectionString}Contratotem/listaContrato${4}/${2}');
      final response = await get('${ConnectionString.connectionString}ContratoItem/listarContrato/${usuario['idUsuario']}/${usuario['tipoUsuarioid']}');
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
      return [];
    }
  }

  Future<ContratoModel> getDetalleContrato(int idContrato) async{
      try
      {
        Response response = await get('${ConnectionString.connectionString}ContratoItem/detalleVistaCliente/$idContrato');
        if(response.status.hasError)
        {
          return Future.error('Error al obtener el detalle del contrato');
        }
        else
        {
          ContratoModel contrato = ContratoModel.fromJson(response.body);
          return contrato;
        }
      }catch(e)
      {
        return Future.error(e);
      }

  }

  Future <List<EventosContratoModel>> getEventosContrato (int contratoId) async{
    try
    {
      Response response = await get('${ConnectionString.connectionString}AdminTareas/procesoContrato/$contratoId');
      if(response.status.hasError)
      {
        return Future.error('Error al obtener los eventos del contrato');
      }
      else
      {
        List<EventosContratoModel> eventos = [];
        for(dynamic evento in response.body)
        {
          eventos.add(EventosContratoModel.fromJson(evento));
        }
        return eventos;
      }
    }catch(e)
    {
      return Future.error(e);
    }
  }

}