import 'package:cuidador_app_mobile/Data/Request/ListaContrato/lista_contrato_request.dart';
import 'package:cuidador_app_mobile/Data/Response/ListContratos/list_contratos_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/estatus_contrato_item_cliente.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/build_timeline.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Modules/ClienteView/estatus_contrato_cliente.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Domain/Model/Objects/eventos_contrato_model.dart';
import '../../../../Domain/Model/Objects/lista_contratos.dart';

class ListContratoController extends GetxController{

  BuildTimeline buildTimeline = BuildTimeline();
  SnackbarUI snackbarUI = SnackbarUI();
  List<TimelineTile> timeLineList = [];
  ListContratosResponse listContratosResponse = ListContratosResponse();
  ListaContratoRequest listContratoRequest = ListaContratoRequest();

  RxList<ListaContratos> contratos = <ListaContratos>[].obs;
  RxList<ListaContratos> contratosFiltrados = <ListaContratos>[].obs;
  DateTime fechaSeleccionada = DateTime.now();
  Rx<ContratoModel> contrato = ContratoModel().obs;

  Rx<EstatusContratoItemCliente> estatusContrato = EstatusContratoItemCliente().obs;

  List<EventosContratoModel> eventos = [];


  RxBool statusLoading = false.obs;
  RxBool statusDetalleLoading = false.obs;
  RxBool statusContratoLoading = false.obs;
  RxBool statusTareaLoading = false.obs;

  RxBool statusEstatusContratoLoading = false.obs;

  @override
  void onInit() async{
    super.onInit();
    // await getContratosPorCliente();
    timeLineList = buildTimeline.construirLista(eventos);
    await getContratosPorCliente();
  }

  Future<void> getContratosPorCliente() async{
    statusLoading.value = true;
    fechaSeleccionada = DateTime.now();
    try{
      contratos.assignAll(await listContratosResponse.getListaContratos());
      // fechaSeleccionada = contratos[0].fechaPrimerContrato!;
      for(ListaContratos c in contratos){
        c.color = asignarColor(c.estatus?.nombre ?? '');
      }
      contratos.refresh();
      contratosFiltrados.assignAll(contratos.where((element) => 
      element.horarioInicio!.day == fechaSeleccionada.day &&
      element.horarioInicio!.month == fechaSeleccionada.month &&
      element.horarioInicio!.year == fechaSeleccionada.year
      ).toList());
      contratosFiltrados.refresh();

      update();
    }catch(e){
      statusLoading.value = false;
    }
    statusLoading.value = false;
  }

  Color asignarColor(String estatus){
    switch (estatus.toUpperCase()) {
      case 'ESPERA':
        return Colors.black;
      case 'ACEPTADA':
        return Colors.green;
      case 'EN CURSO':
        return Colors.orange[700]!;
      case 'RECHAZADA':
        return Colors.red[900]!;
      case 'CONCLUIDA':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  void changeFechaSeleccionada(DateTime fecha){
    fechaSeleccionada = fecha;
    contratosFiltrados.assignAll(contratos.where((element) => 
    element.horarioInicio!.day == fechaSeleccionada.day &&
    element.horarioInicio!.month == fechaSeleccionada.month &&
    element.horarioInicio!.year == fechaSeleccionada.year
    ).toList());
    contratosFiltrados.refresh();
    update();
  }

  Future<void> getDetalleContrato(int idContrato) async{
    statusDetalleLoading.value = true;
    try{
      contrato.value = await listContratosResponse.getDetalleContrato(idContrato);
      statusDetalleLoading.value = false;
    }catch(e){
      statusDetalleLoading.value = false;
    }
  }

  Future<void> eventosPorContrato(int indice) async{
    eventos.clear();
    timeLineList.clear();
    eventos.assignAll(await listContratosResponse.getEventosContrato(indice));
    timeLineList = buildTimeline.construirLista(eventos);
    update();
  }

  Future<void> cambiarEstatusContrato(int idContrato, int idEstatus) async{
    statusContratoLoading.value = true;
    try{
      await listContratoRequest.cambiarEstatusContrato(idContrato, idEstatus);
      Get.back();
      await getContratosPorCliente();
      snackbarUI.snackbarSuccess('Estatus cambiado!', 'Se ha cambiado el estatus del contrato');
    }catch(e){
      snackbarUI.snackbarError('Ups! ha ocurrido un error!', 'No se ha cambiado el estatus del contrato');
      statusContratoLoading.value = false;
    }
    statusContratoLoading.value = false;
  }

  Future<void> cambiarEstatusTarea(int estatus) async{
    
    statusTareaLoading.value = true;
    int tarea = eventos.firstWhere((element) => element.esTarea == true).id!;

    try{
      await listContratoRequest.cambiarEstatusTarea(tarea, estatus);
      Get.back();
      await getContratosPorCliente();
      snackbarUI.snackbarSuccess('Estatus cambiado!', 'Se ha cambiado el estatus del contrato');
    }catch(e){
      snackbarUI.snackbarError('Ups! ha ocurrido un error!', 'No se ha cambiado el estatus del contrato');
      statusTareaLoading.value = false;
    }
    statusTareaLoading.value = false;
  }

  Future<void> getEstatusContratoCliente(int idContratoItem) async{
    statusEstatusContratoLoading.value = true;
    try{
      var response = await listContratosResponse.getEstatusContratoCliente(idContratoItem);
      estatusContrato.value = response;
      statusEstatusContratoLoading.value = false;
      Get.toNamed('/estatusContratoCliente');
    }catch(e){
      snackbarUI.snackbarError('Ups! ha ocurrido un error!', 'No se ha podido obtener el estatus del contrato');
      statusEstatusContratoLoading.value = false;
    }
  }


}