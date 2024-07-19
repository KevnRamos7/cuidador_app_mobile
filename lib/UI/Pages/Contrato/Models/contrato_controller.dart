// import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Data/Response/Contrato/contrato_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/extra_functions.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/contrato_item_list.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:get_storage/get_storage.dart';

import '../../../../Domain/Model/Contrato/contrato_item_model.dart';
import '../../../../Domain/Model/Contrato/tareas_contrato_model.dart';

class ContratoController extends GetxController{

  RxBool cbxAsignTask = false.obs;

  UsuarioModel personaCuidador = UsuarioModel();
  SnackbarUI  snackbarUI = SnackbarUI();
  ContratoResponse contratoResponse = ContratoResponse();
  ExtraFunctions extraFunctions = ExtraFunctions();

  ContratoItemList contratoItemList = ContratoItemList();
  List<ContratoItemModel> fechasConCita = [];
  RxList<String> fechasNoDisponiblesSet =  RxList<String>();
  var horariosInicialesDisponibles = <String>[];
  var horariosFinalesDisponibles = <String>[].obs;
  var horariosForTask = <String>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  String selectedTimeStart = 'Hora Inicio';
  String selectedTimeEnd = 'Hora Fin';

  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();
  DateTime dateTask = DateTime.now();
  DateTime date = DateTime.now();

  Rx<TextEditingController> txtObservacion = TextEditingController().obs;
  Rx<TextEditingController> txtTituloTarea = TextEditingController().obs;
  Rx<TextEditingController> txtDescripcionTarea = TextEditingController().obs;

  RxList<ContratoItemModel> contratoItems = RxList<ContratoItemModel>();
  RxList<TareasContratoModel> tareasContrato = RxList<TareasContratoModel>();


  @override
  void onInit(){
    super.onInit();
    setPersonaCuidador();
  }

  void setPersonaCuidador() async{
    try
    {
      personaCuidador = Get.arguments as UsuarioModel;

      fechasConCita = await contratoResponse.getFechasNoDisponibles();
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date.toString()));
      fechasNoDisponiblesSet.refresh();
      horariosInicialesDisponibles = await extraFunctions.generateAvailableTimes(fechasConCita, date.toString().split(" ")[0]);
      update();
    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido Un Error', 'No se ha podido obtener la informacion del cuidador.');
    }
  }

  void onDateChanged(DateTime date){
      selectedDate = date.obs;
  }

  void onTimeStartChanged(String time){
    selectedTimeStart = time;
    int index = horariosInicialesDisponibles.indexOf(time);
    horariosFinalesDisponibles.value = horariosInicialesDisponibles.sublist(index + 4);
    horariosFinalesDisponibles.refresh();
    update();
  }

  void cbxTaskOnChange(bool value){
    cbxAsignTask.value = value;
    tareasContrato.clear(); // temporal
    String horaInicio = selectedTimeStart;//.padLeft(4, '0');
    String horaFin = selectedTimeEnd;//.padLeft(4, '0');

    String inicial = extraFunctions.stringToDateTime(horaInicio).toString();
    String fin = extraFunctions.stringToDateTime(horaFin).toString();

    horariosForTask.value = extraFunctions.availableTimesForTask(inicial, fin ,tareasContrato);
    horariosForTask.refresh();
  }

  // Se agrega un listado de tareas al contrato item en curso
  void addTareasContrato(){

    DateTime horarioInicio = DateTime(
      date.year, date.month, date.day, 
      dateStart.hour, dateStart.minute
    );
    DateTime horarioFin = DateTime(
      date.year, date.month, date.day, 
      dateEnd.hour, dateEnd.minute
    );

    tareasContrato.add(
      TareasContratoModel(
        idTareasContrato: 0,
        tituloTarea: txtTituloTarea.value.text,
        descripcionTarea: txtDescripcionTarea.value.text,
        tipoTarea: 'Tarea',
        fechaInicio: horarioInicio.toIso8601String(),
        fechaFin: horarioFin.toIso8601String(),
      )
    );

    txtTituloTarea.value.clear();
    txtDescripcionTarea.value.clear();

  }
  // Se agrega el contratoItem a la lista de contratoItems
  void saveContratoItem(){

    DateTime horarioInicio = DateTime(
      date.year, date.month, date.day, 
      dateStart.hour, dateStart.minute
    );
    DateTime horarioFin = DateTime(
      date.year, date.month, date.day, 
      dateEnd.hour, dateEnd.minute
    );

    // Se agrega el contratoItem a la lista de contratoItems
    contratoItems.add(
      ContratoItemModel(
        idContratoItem: 0,
        horarioInicioPropuesto: horarioInicio.toIso8601String(),
        horarioFinPropuesto: horarioFin.toIso8601String(),
        observaciones: txtObservacion.value.text,
        tareasContrato: tareasContrato,
      )
    );

    snackbarUI.snackbarSuccess('Fecha agregada con exito!', 'Se ha agregado la fecha al contrato.');

    // //Vacia la lista de tareas
    // tareasContrato.clear();
    // tareasContrato.refresh();

  }
  //Carga el resumen del contrato
  void saveContrato(){

    PersonaModel personaCliente = PersonaModel(
      idPersona: 1, //GetStorage().read('usuario')['id_persona'],
    );

    ContratoModel contrato = ContratoModel(
      idContrato: 0,
      personaCuidador: personaCuidador.persona!.first,
      personaCliente: personaCliente,
      contratoItem: RxList<ContratoItemModel>(
        contratoItems
      ) ,
    );

    contrato.contratoItem!.isNotEmpty ? Get.offNamed('/resumen_contrato', arguments: contrato) : snackbarUI.snackbarError('Error', 'No se ha agregado ninguna fecha al contrato.');

    Get.offNamed('/resumen_contrato', arguments: contrato);

  }

}