import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/estatus_contrato_item_cliente.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/eventos_contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListContratosResponse extends GetConnect{

  SnackbarUI  snackbarUI = SnackbarUI();

  Future<List<ListaContratos>> getListaContratos() async{
    try
    {
      dynamic usuario = GetStorage().read('usuario');
      dynamic persona = GetStorage().read('perfil');
      // final response = await get('${ConnectionString.connectionString}Contratotem/listaContrato${4}/${2}');
      Response response = await get('${ConnectionString.connectionString}ContratoItem/listarContratoByPersonId/${persona['idPersona']}/${usuario['tipoUsuarioid']}');
      
      switch(response.statusCode){
        case 200:
          List<ListaContratos> contratos = [];
          for(var item in response.body){
            contratos.add(ListaContratos.fromJson(item));
          }
          return contratos;
        case 400:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al obtener la lista de contratos');
        case 500:
          snackbarUI.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al obtener la lista de contratos');
        default:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return [];

      }
    }
    catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return [];
    }
  }

  Future<ContratoModel> getDetalleContrato(int idContrato) async{
      try
      {
        Response response = await get('${ConnectionString.connectionString}ContratoItem/detalleVistaCliente/$idContrato');
        
        switch(response.statusCode){
          case 200:  
            ContratoModel contrato = ContratoModel.fromJson(response.body);
            return contrato;
          case 400:
            snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
            return ContratoModel();
          case 500:
            snackbarUI.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
            return ContratoModel();
          default:
            snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
            return ContratoModel();
        }


      }catch(e)
      {
        print(e);
        snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
        return ContratoModel();
      }

  }

  Future <EstatusContratoItemCliente> getEstatusContratoCliente(int idContratoItem) async {

    try
    {
      Response response = await get('${ConnectionString.connectionString}contratoItem/verEstatusContratoItem/$idContratoItem');
      
      switch(response.statusCode){
        case 200:
          EstatusContratoItemCliente estatus = EstatusContratoItemCliente.fromJson(response.body);
          return estatus;
        case 400:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al obtener el estatus del contrato');
        case 500:
          snackbarUI.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al obtener el estatus del contrato');
        default:
          snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al obtener el estatus del contrato');
      }  
          
    }catch(e)
    {
      snackbarUI.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
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