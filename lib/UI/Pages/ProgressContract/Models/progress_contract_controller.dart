import 'package:cuidador_app_mobile/Data/Request/ListaContrato/lista_contrato_request.dart';
import 'package:cuidador_app_mobile/Data/Response/ListContratos/list_contratos_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/lista_contratos.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Models/rules_change_estatus.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../Domain/Model/Contrato/contrato_model.dart';

class ProgressContractController extends GetxController{

  RxInt currectStep = 0.obs;
  Rx<ContratoModel> contrato = ContratoModel().obs;

  Map<String, int> status = {
    'ESPERA' : 18,
    'ACEPTADA': 7,
    'EN CURSO': 19,
    'RECHAZADA': 8,
    'CONCLUIDA': 9,
    'POSPUESTA': 26
  };

  ListaContratoRequest listaContratoRequest = ListaContratoRequest();
  ListContratosResponse listContratosResponse = ListContratosResponse();
  SnackbarUI snackbarUI = SnackbarUI();
  RulesChangeEstatus rules = RulesChangeEstatus();

  RxBool loadingAction = false.obs;
  RxBool loadingScreen = false.obs;
  Rx<LatLng> address = const LatLng(0, 0).obs;
  Rx<ListaContratos> contratoCV = ListaContratos().obs;

  @override
  void onInit() async{
    try{
      contratoCV.value = Get.arguments;
    }
    catch(e){
      snackbarUI.snackbarError('Error al obtener el contrato', 'Intenta más tarde');
    }

    await getContract(contratoCV.value.idContratoItem ?? 0);
    address.value = await getCoordinatesFromAddress().then((value) => value!);
    super.onInit();
  }

  Future<LatLng?> getCoordinatesFromAddress() async {
      try {
        String direccion = 
      '${contrato.value.personaCuidador?.domicilio?.calle}, ${contrato.value.personaCuidador?.domicilio?.numeroExterior}, ${contrato.value.personaCuidador?.domicilio?.colonia}, ${contrato.value.personaCuidador?.domicilio?.ciudad}, ${contrato.value.personaCuidador?.domicilio?.estado}, ${contrato.value.personaCuidador?.domicilio?.pais}'; 
        List<Location> locations = await locationFromAddress(direccion);
        if (locations.isNotEmpty) {
          return LatLng(locations[0].latitude, locations[0].longitude);
        }
      } catch (e) {
        print("Error obteniendo coordenadas: $e");
      }
      return null;
    }

  Future<void> getContract(int idContrato) async {
    loadingScreen.value = true;
    try
    {
      contrato.value = await listContratosResponse.getDetalleContrato(idContrato);
    }
    catch(e)
    {
      snackbarUI.snackbarError('Error al obtener el contrato', 'Intenta más tarde');
    }
    finally
    {
      loadingScreen.value = false;
    }
  }

  Future<void> locationAction(String type) async{

    bool response = false;
    int newStatus = 0;
    String newStatusName = '';
    int idEstatusContrato = contrato.value.contratoItem![0].estatus!.idEstatus ?? 0;
    int idContrato = contrato.value.contratoItem![0].idContratoItem ?? 0;

    loadingAction.value = true;
    switch (type) 
    {
      case 'accept' : 
        var canChange = rules.canChangeEstatusAccept(idEstatusContrato);
        if(canChange.item1){
          response = await listaContratoRequest.cambiarEstatusContrato(idContrato, canChange.item2);
          newStatus = canChange.item2;
          newStatusName = status.keys.firstWhere((key) => status[key] == newStatus);
        }
        break;
      case 'start':
        var canChange = rules.canChangeEstatusStart(idEstatusContrato);
        if(canChange.item1){
          response = await listaContratoRequest.cambiarEstatusContrato(idContrato, canChange.item2);
          newStatus = canChange.item2;
          newStatusName = status.keys.firstWhere((key) => status[key] == newStatus);
        }
        break;
      default:
        var canChange = rules.canChangeEstatusReject(idEstatusContrato);
        if(canChange.item1){
          response = await listaContratoRequest.cambiarEstatusContrato(idContrato, canChange.item2);
          newStatus = canChange.item2;
          newStatusName = status.keys.firstWhere((key) => status[key] == newStatus);
          Get.back();
        }
        break;
    }
    if(response == true){
      contrato.value.contratoItem![0].estatus = EstatusModel(
        idEstatus: newStatus,
        nombre: newStatusName
      );
      snackbarUI.snackbarSuccess('Operación exitosa', 'El contrato ha sido actualizado correctamente');
    }
    loadingAction.value = false;
  }

  Future<void> taskAction(String type, int indiceTask) async {

    bool response = false;
    int newStatus = 0;

    loadingAction.value = true;
    switch (type) 
    {
      case 'start':
        if(contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus == 7 || contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus == 26){ // SI ESTABA EN ESPERA
          response = await listaContratoRequest.cambiarEstatusTarea(contrato.value.contratoItem?[0].tareasContrato?[indiceTask].idTareasContrato ?? 0, 19);
          newStatus = 19;
          break;
        }
        snackbarUI.snackbarInfo('Ya has iniciado la tarea', 'No puedes iniciar la tarea más de una vez');
        break;
      case 'finish':
        if(contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus == 19){
          response = await listaContratoRequest.cambiarEstatusTarea(contrato.value.contratoItem?[0].tareasContrato?[indiceTask].idTareasContrato ?? 0, 9);
          newStatus = 9;
          break;
        }
        snackbarUI.snackbarInfo('No has iniciado la tarea', 'No puedes finalizar la tarea sin haber iniciado la tarea');
        break;
      case 'postpone':
        if(contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus == 7 || contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus == 18){
          response = await listaContratoRequest.cambiarEstatusTarea(contrato.value.contratoItem?[0].tareasContrato?[indiceTask].idTareasContrato ?? 0, 26);
          newStatus = 26;
          break;
        }
        snackbarUI.snackbarInfo('No has iniciado la tarea o esta pospuesta la tarea', 'No puedes posponer la tarea sin haber iniciado la tarea');
        break;
      default:  // cancel
        if(contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus! == 8 || contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus! == 9){
          response = await listaContratoRequest.cambiarEstatusTarea(contrato.value.contratoItem?[0].tareasContrato?[indiceTask].idTareasContrato ?? 0, 8);
          newStatus = 8;
          break;
        }
        snackbarUI.snackbarInfo('Tarea ya rechazada o concluida', 'No puedes rechazar una tarea ya rechazada o concluida');
        break;
    }

    if(response == true){
      contrato.value.contratoItem![0].tareasContrato![indiceTask].estatus = newStatus;
      snackbarUI.snackbarSuccess('Operación exitosa', 'La tarea ha sido actualizada correctamente');
    }
    loadingAction.value = false;
  }

  Future<void> finishContract() async {
    bool response = false;
    loadingAction.value = true;

    for(var i in contrato.value.contratoItem![0].tareasContrato!.where((e) => e.estatus != 9)){
      response = await listaContratoRequest.cambiarEstatusTarea(i.idTareasContrato ?? 0, 9);
      if(response == false){
        snackbarUI.snackbarError('Error al finalizar la tarea', 'Intenta más tarde');
        loadingAction.value = false;
        return;
      }
      i.estatus = 9;
    }

    response = await listaContratoRequest.cambiarEstatusContrato(contrato.value.contratoItem![0].idContratoItem ?? 0, 9);
    if(response == true){
      snackbarUI.snackbarSuccess('Operación exitosa', 'El contrato ha sido finalizado correctamente');
      await Future.delayed(const Duration(seconds: 3));
      Get.offNamedUntil('/list_contratos', (route) => false);
    }
    loadingAction.value = false;

  }


}