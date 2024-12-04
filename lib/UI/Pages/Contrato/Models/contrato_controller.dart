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
import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:get_storage/get_storage.dart';

import '../../../../Data/Response/Finanzas/finanzas_response.dart';
import '../../../../Domain/Model/Contrato/contrato_item_model.dart';
import '../../../../Domain/Model/Contrato/tareas_contrato_model.dart';
import '../../../../Domain/Model/Objects/finanzas_cliente.dart';

class ContratoController extends GetxController{

  RxBool cbxAsignTask = false.obs;

  UsuarioModel personaCuidador = UsuarioModel();
  SnackbarUI  snackbarUI = SnackbarUI();
  ContratoResponse contratoResponse = ContratoResponse();
  ExtraFunctions extraFunctions = ExtraFunctions();
  ContratoItemList contratoItemList = ContratoItemList();
  FinanzasResponse finanzasResponse = FinanzasResponse();


  List<ContratoItemModel> fechasConCita = [];
  RxList<String> fechasNoDisponiblesSet =  RxList<String>();
  RxList<String> horariosInicialesDisponibles = <String>[].obs;
  var horasInicialesForEndTimes = <String>[];
  var horariosFinalesDisponibles = <String>[].obs;
  var horariosForTask = <String>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedTimeStart = ''.obs;
  // RxString timetest = ''.obs;
  RxString selectedTimeEnd = ''.obs;
  RxString selectedTimeTask = ''.obs;

  DateTime date = DateTime.now().add(const Duration(days: 1));

  RxString hora = ''.obs;
  RxBool isSelected = false.obs;
  Rx<FinanzasCliente> saldo = FinanzasCliente().obs;

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

      fechasConCita = await contratoResponse.getFechasNoDisponibles(personaCuidador.persona!.first.idPersona!);
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date));
      fechasNoDisponiblesSet.refresh();
      horariosInicialesDisponibles.value = extraFunctions.onlyForStartTime(fechasConCita, date);
      update();
      dynamic usuario = GetStorage().read('usuario');
      saldo.value = await finanzasResponse.getFinanzasCliente(usuario['idUsuario']); 
    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido Un Error', 'No se ha podido obtener la informacion del cuidador.');
    }
  }


 // TODO  Funciones de la vista

  void onDateChanged(DateTime date){
      selectedDate = date.obs;
      horariosInicialesDisponibles.value = extraFunctions.onlyForStartTime(fechasConCita, selectedDate.value);
      horariosInicialesDisponibles.refresh();
      selectedTimeStart.value = '';
      selectedTimeEnd.value = '';
      update();
  }

  void onTimeStartChanged(String time){
    selectedTimeStart.value = time;
    List<String> horariosFinales = extraFunctions.selectedTimeEnd(horariosInicialesDisponibles, extraFunctions.stringToDateTime(selectedTimeStart.value));

    horariosFinalesDisponibles.value = horariosFinales;
    horariosFinalesDisponibles.refresh();
    update();
  }

  void cbxTaskOnChange(bool value){
    if(value == true && selectedTimeStart.isNotEmpty && selectedTimeEnd.isNotEmpty){
      cbxAsignTask.value = value;
      String horaInicio = selectedTimeStart.padLeft(5, '0');//.padLeft(4, '0');
      String horaFin = selectedTimeEnd.padLeft(5, '0');//.padLeft(4, '0');

      DateTime inicial = extraFunctions.stringToDateTime(horaInicio);
      DateTime fin = extraFunctions.stringToDateTime(horaFin);

      horariosForTask.value = extraFunctions.availableTimesForTask(inicial, fin ,tareasContrato);
      horariosForTask.refresh();
    }
    else if(value == false){
      cbxAsignTask.value = value;
    }
    else{
      snackbarUI.snackbarError('Sin horario seleccionado!', 'Debes seleccionar un horario de inicio y fin para poder asignar tareas.');
    }
  }

  void onTimeSelected(String value, int typeTime){ // 1 es inicial, 2 es final, 3 es de tarea
    switch(typeTime){
      case 1:
        onTimeStartChanged(value);
        break;
      case 2: 
        selectedTimeEnd.value = value;
        break;
      case 3:
        selectedTimeTask.value = value;
        break;
    }
    update();
  }

  // TODO Funciones de la logica

  // Se agrega un listado de tareas al contrato item en curso
  void addTareasContrato(){

    if(txtTituloTarea.value.text.isEmpty){
      snackbarUI.snackbarError('Campo Vacio', 'Debes agregar un titulo a la tarea.');
      return;
    }else if (selectedTimeTask.isEmpty){
      snackbarUI.snackbarError('Campo Vacio', 'Debes seleccionar un horario para la tarea.');
      return;
    }

    // Se crea el objeto tipo DateTime de la fecha de inicio
    DateTime horario = extraFunctions.stringToDateTime(selectedTimeTask.padLeft(5, '0'));
    DateTime fechaFin = extraFunctions.stringToDateTime(selectedTimeEnd.padLeft(5, '0'));
    DateTime fechaInicio = extraFunctions.stringToDateTime(selectedTimeStart.padLeft(5,'0'));

    tareasContrato.add(
      TareasContratoModel(
        idTareasContrato: 0,
        tituloTarea: txtTituloTarea.value.text,
        descripcionTarea: txtDescripcionTarea.value.text,
        tipoTarea: 'Tarea',
        fechaRealizar: horario
      )
    );

    horariosForTask.assignAll(extraFunctions.availableTimesForTask(fechaInicio, fechaFin, tareasContrato));
    txtTituloTarea.value.clear();
    txtDescripcionTarea.value.clear();
    horariosForTask.refresh();
    update();
  }

  void addTareasFromModal(int indiceContrato){

    if(txtTituloTarea.value.text.isEmpty){
      snackbarUI.snackbarError('Campo Vacio', 'Debes agregar un titulo a la tarea.');
      return;
    }else if (selectedTimeTask.isEmpty){
      snackbarUI.snackbarError('Campo Vacio', 'Debes seleccionar un horario para la tarea.');
      return;
    }

    DateTime horario = extraFunctions.stringToDateTime(selectedTimeTask.padLeft(5, '0'));
    contratoItems[indiceContrato].tareasContrato!.add(TareasContratoModel(
        idTareasContrato: 0,
        tituloTarea: txtTituloTarea.value.text,
        descripcionTarea: txtDescripcionTarea.value.text,
        tipoTarea: 'Tarea',
        fechaRealizar: horario
    ));
    txtTituloTarea.value.clear();
    txtDescripcionTarea.value.clear();
    horariosForTask.refresh();
    Get.back();
    update();
  }

  // Se agrega el contratoItem a la lista de contratoItems
  void saveContratoItem(){

    if(selectedTimeStart.isEmpty || selectedTimeEnd.isEmpty){
      snackbarUI.snackbarError('Sin horario seleccionado', 'Debes seleccionar un horario');
    }

    // Se crea el objeto tipo DateTime de la fecha de inicio y fin
    DateTime horarioInicio = extraFunctions.stringToDateTime(selectedTimeStart.value);
    DateTime horarioFin = extraFunctions.stringToDateTime(selectedTimeEnd.value);

    //Cambiar la fecha de los horarios inicio y fin con respecto a la fecha seleccionada
    horarioInicio = DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day, horarioInicio.hour, horarioInicio.minute);
    horarioFin = DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day, horarioFin.hour, horarioFin.minute);

    // Se agrega el contratoItem a la lista de contratoItems
    contratoItems.add(
      ContratoItemModel(
        idContratoItem: 0,
        horarioInicioPropuesto: horarioInicio,
        horarioFinPropuesto: horarioFin,
        observaciones: txtObservacion.value.text,
        tareasContrato: RxList<TareasContratoModel>(
          tareasContrato
        ),
        importeCuidado: personaCuidador.horariosCuidador!.first.precioPorHora! * horarioFin.difference(horarioInicio).inMinutes / 60
      )
    );

    if(contratoItems.isNotEmpty){
      fechasConCita.add(contratoItems.last);
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date));
      fechasNoDisponiblesSet.refresh();
      selectedTimeStart.value = '';
      selectedTimeEnd.value = '';
      txtObservacion.value.clear();
      tareasContrato.clear();
      horariosForTask.clear();
      horariosFinalesDisponibles.clear();
      horariosInicialesDisponibles.value = extraFunctions.onlyForStartTime(fechasConCita, date);
      cbxAsignTask.value = false;
      snackbarUI.snackbarSuccess('Fecha agregada con exito!', 'Se ha agregado la fecha al contrato.');
    }

  }
  //Carga el resumen del contrato
  void saveContrato(){
    PersonaModel personaCliente = PersonaModel.fromJson(GetStorage().read('perfil'));

    ContratoModel contrato = ContratoModel(
      idContrato: 0,
      personaCuidador: personaCuidador.persona!.first,
      personaCliente: personaCliente,
      contratoItem: RxList<ContratoItemModel>(
        contratoItems
      ) ,
    );

    contrato.contratoItem!.isNotEmpty ? Get.toNamed('/resumen_contrato', arguments: contrato) : snackbarUI.snackbarError('Error', 'No se ha agregado ninguna fecha al contrato.');

    Get.offNamed('/resumen_contrato', arguments: contrato);

  }

  void modfifyContratoItem(ContratoItemModel contratoItem, DateTime? value, int indexContrato, bool isDate) async{

    Get.back(canPop: true, closeOverlays: true);

    DateTime horarioInicioValide = contratoItem.horarioInicioPropuesto!;
    // Se le cambia la fecha de inicio y fin al contratoItem manteniendo la hora

    DateTime horarioInicio = contratoItem.horarioInicioPropuesto!;
    DateTime horarioFin = contratoItem.horarioFinPropuesto!;

    if(isDate){

      horarioInicio = DateTime(value!.year, value.month, value.day, horarioInicio.hour, horarioInicio.minute);
      horarioFin = DateTime(value.year, value.month, value.day, horarioFin.hour, horarioFin.minute);

      RxList<String> horasDisponiblesNuevaFecha = RxList<String>();
      horasDisponiblesNuevaFecha.assignAll(extraFunctions.onlyForStartTime(fechasConCita, value));

      String horaInicioActual = '${horarioInicio.hour.toString().padLeft(2, '0')}:${horarioInicio.minute.toString().padLeft(2, '0')}';
      String horaFinActual = '${horarioFin.hour.toString().padLeft(2, '0')}:${horarioFin.minute.toString().padLeft(2, '0')}';

      if(horasDisponiblesNuevaFecha.contains(horaInicioActual) || horasDisponiblesNuevaFecha.contains(horaFinActual)){
        snackbarUI.snackbarError('Horario No Disponible', 'Elimina el contrato actual para poder modificar la fecha.');
        contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
        return;
      }
      
      contratoItems[indexContrato].horarioInicioPropuesto = horarioInicio;
      contratoItems[indexContrato].horarioFinPropuesto = horarioFin;

      for (var t in contratoItems[indexContrato].tareasContrato!) {
        DateTime fechaRealizar = t.fechaRealizar!;
        t.fechaRealizar = DateTime(value.year, value.month, value.day, fechaRealizar.hour, fechaRealizar.minute);
      }

      if(horarioInicio.year != horarioInicioValide.year || horarioInicio.month != horarioInicioValide.month || horarioInicio.day != horarioInicioValide.day){
      snackbarUI.snackbarSuccess('Fecha Modificada Con Exito!', 'Se ha modificado la fecha del contrato.');
      contratoItems.refresh();
      contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
      }
      else{
        snackbarUI.snackbarError('No Se Modifico La Fecha', 'La fecha de inicio del contrato sigue siendo la misma.');
      }

    }
    else{
      
      int hora = int.parse(selectedTimeStart.padLeft(5, '0').split(":")[0].substring(0, 2));
      int minuto = int.parse(selectedTimeStart.split(":")[1].substring(0, 2));
      int horaFin = int.parse(selectedTimeEnd.padLeft(5, '0').split(":")[0].substring(0, 2));
      int minutoFin = int.parse(selectedTimeEnd.split(":")[1].substring(0, 2));

      horarioInicio = DateTime(horarioInicio.year, horarioInicio.month, horarioInicio.day, hora, minuto);
      horarioFin = DateTime(horarioFin.year, horarioFin.month, horarioFin.day, horaFin, minutoFin);

      //Cambiar fechas de las tareas
      if (contratoItems[indexContrato].tareasContrato != null && contratoItems[indexContrato].tareasContrato!.isNotEmpty) {
        // Guarda el horario de inicio original
        DateTime horarioOriginal = contratoItems[indexContrato].horarioInicioPropuesto!;

        // Recorre todas las tareas del contrato
        for (TareasContratoModel tarea in contratoItems[indexContrato].tareasContrato!) {
          // Calcula la diferencia en minutos entre la fecha original de la tarea y el horario original
          int diferenciaEnMinutos = tarea.fechaRealizar!.difference(horarioOriginal).inMinutes;

          // Aplica la diferencia al nuevo horario de inicio
          DateTime nuevaFechaRealizar = horarioInicio.add(Duration(minutes: diferenciaEnMinutos));

          // Actualiza la fecha de realización de la tarea
          tarea.fechaRealizar = nuevaFechaRealizar;
        }
      }


      contratoItems[indexContrato].horarioInicioPropuesto = horarioInicio;
      contratoItems[indexContrato].horarioFinPropuesto = horarioFin;

      double horasContratas = horarioFin.difference(horarioInicio).inMinutes / 60;
      double costoTotal = horasContratas * personaCuidador.horariosCuidador!.first.precioPorHora!;

      contratoItems[indexContrato].importeCuidado = costoTotal;

      if((horarioInicio.hour != horarioInicioValide.hour || horarioInicio.minute != horarioInicioValide.minute)
      || (horarioFin.hour != horarioInicioValide.hour || horarioFin.minute != horarioInicioValide.minute)){
      snackbarUI.snackbarSuccess('Hora Modificada Con Exito!', 'Se ha modificado la hora del contrato.');
      selectedTimeStart.value = '';
      selectedTimeEnd.value = '';
      contratoItems.refresh();
      
      fechasConCita.removeWhere((element) => element.horarioInicioPropuesto! == horarioInicioValide && element.horarioFinPropuesto! == horarioInicioValide,);
      fechasConCita.add(contratoItems[indexContrato]);
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date));
      fechasNoDisponiblesSet.refresh();
      horariosInicialesDisponibles.value = extraFunctions.onlyForStartTime(fechasConCita, date);
      horariosFinalesDisponibles.clear();

      contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
      }
      else{
        snackbarUI.snackbarError('No Se Modifico La Hora', 'La hora del contrato sigue siendo la misma.');
      }

    }
    
  }

  void modifyObservaciones(String observaciones, int indexContrato){
    Get.back();
    contratoItems[indexContrato].observaciones = observaciones;
    contratoItems.refresh();
  }

  void modifyTareasContrato(String ediciontext, int indiceTarea, int indexContrato, bool isTitulo){
    Get.back();
    if(isTitulo){ 
      contratoItems[indexContrato].tareasContrato![0].tituloTarea = ediciontext;
    }
    else{
      contratoItems[indexContrato].tareasContrato![0].descripcionTarea = ediciontext;
    }
    contratoItems.refresh();
    //contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
  }

  void modifyHorarioTarea(String horario, int indexContrato, int indexTarea){
    Get.back();
    int hora = int.parse(horario.padLeft(5, '0').split(":")[0]);
    int minuto = int.parse(horario.split(":")[1]);
    DateTime horarioInicio = contratoItems[indexContrato].tareasContrato![indexTarea].fechaRealizar!;
    horarioInicio = DateTime(horarioInicio.year, horarioInicio.month, horarioInicio.day, hora, minuto);
    contratoItems[indexContrato].tareasContrato![indexTarea].fechaRealizar = horarioInicio;
    contratoItems.refresh();
  }

  void deleteContratoOrTask(int indexContrato, int indexTarea){
    if(indexTarea == -1){

      ContratoItemModel item = contratoItems[indexContrato];
      fechasConCita.removeWhere((element) => element.horarioInicioPropuesto! == item.horarioInicioPropuesto && element.horarioFinPropuesto! == item.horarioFinPropuesto,);
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date));
      fechasNoDisponiblesSet.refresh();

      contratoItems.removeAt(indexContrato);
      contratoItems.refresh();
      
      horariosInicialesDisponibles = extraFunctions.onlyForStartTime(fechasConCita, date);
      selectedTimeStart.value = '';
      selectedTimeEnd.value = '';
      Get.back();
      snackbarUI.snackbarSuccess('Contrato Eliminado', 'Se ha eliminado el contrato.');
      // contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, 0);
    }
    else{
      contratoItems[indexContrato].tareasContrato!.removeAt(indexTarea);
      contratoItems.refresh();
      horariosForTask.assignAll(extraFunctions.availableTimesForTask(contratoItems[indexContrato].horarioInicioPropuesto!, contratoItems[indexContrato].horarioFinPropuesto!, contratoItems[indexContrato].tareasContrato!));
      snackbarUI.snackbarSuccess('Tarea Eliminada', 'Se ha eliminado la tarea.');
      // contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, 0);
    }
  }



}