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
  var horasInicialesForEndTimes = <String>[];
  var horariosFinalesDisponibles = <String>[].obs;
  var horariosForTask = <String>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  String selectedTimeStart = '';
  String selectedTimeEnd = '';
  String selectedTimeTask = '';

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
      horariosInicialesDisponibles = extraFunctions.onlyForStartTime(fechasConCita, date.toString().split(" ")[0]);
      update();
    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido Un Error', 'No se ha podido obtener la informacion del cuidador.');
    }
  }

 // TODO  Funciones de la vista

  void onDateChanged(DateTime date){
      selectedDate = date.obs;
  }

  void onTimeStartChanged(String time){
    selectedTimeStart = time;
    List<String> horariosFinales = extraFunctions.selectedTimeEnd(horariosInicialesDisponibles, selectedTimeStart);

    horariosFinalesDisponibles.value = horariosFinales;
    horariosFinalesDisponibles.refresh();
    update();
  }

  void cbxTaskOnChange(bool value){
    if(value == true && selectedTimeStart.isNotEmpty && selectedTimeEnd.isNotEmpty){
      cbxAsignTask.value = value;
      String horaInicio = selectedTimeStart;//.padLeft(4, '0');
      String horaFin = selectedTimeEnd;//.padLeft(4, '0');

      String inicial = extraFunctions.stringToDateTime(horaInicio).toString();
      String fin = extraFunctions.stringToDateTime(horaFin).toString();

      horariosForTask.value = extraFunctions.availableTimesForTask(inicial, fin ,tareasContrato);
      horariosForTask.refresh();
    }else{
      snackbarUI.snackbarError('Sin horario seleccionado!', 'Debes seleccionar un horario de inicio y fin para poder asignar tareas.');
    }
  }

  // TODO Funciones de la logica

  // Se agrega un listado de tareas al contrato item en curso
  void addTareasContrato(){

    // Se crea el objeto tipo DateTime de la fecha de inicio
    DateTime horario = extraFunctions.stringToDateTime(selectedTimeTask);
    String fechaFin = extraFunctions.stringToDateTime(selectedTimeEnd.padLeft(5, '0')).toString();
    String fechaInicio = extraFunctions.stringToDateTime(selectedTimeStart.padLeft(5,'0')).toString();

    tareasContrato.add(
      TareasContratoModel(
        idTareasContrato: 0,
        tituloTarea: txtTituloTarea.value.text,
        descripcionTarea: txtDescripcionTarea.value.text,
        tipoTarea: 'Tarea',
        fechaRealizar: horario.toString()
      )
    );
    horariosForTask.assignAll(extraFunctions.availableTimesForTask(fechaInicio, fechaFin, tareasContrato));
    txtTituloTarea.value.clear();
    txtDescripcionTarea.value.clear();
    horariosForTask.refresh();
    update();
  }
  // Se agrega el contratoItem a la lista de contratoItems
  void saveContratoItem(){

    // Se crea el objeto tipo DateTime de la fecha de inicio y fin
    DateTime horarioInicio = extraFunctions.stringToDateTime(selectedTimeStart);
    DateTime horarioFin = extraFunctions.stringToDateTime(selectedTimeEnd);

    // Se agrega el contratoItem a la lista de contratoItems
    contratoItems.add(
      ContratoItemModel(
        idContratoItem: 0,
        horarioInicioPropuesto: horarioInicio.toString(),
        horarioFinPropuesto: horarioFin.toString(),
        observaciones: txtObservacion.value.text,
        tareasContrato: RxList<TareasContratoModel>(
          tareasContrato
        ),
        importeCuidado: personaCuidador.salarioCuidador! * horarioFin.difference(horarioInicio).inMinutes / 60
      )
    );

    if(contratoItems.isNotEmpty){
      fechasConCita.add(contratoItems.last);
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date.toString()));
      fechasNoDisponiblesSet.refresh();
      selectedTimeStart = '';
      selectedTimeEnd = '';
      txtObservacion.value.clear();
      tareasContrato.clear();
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

    DateTime horarioInicioValide = DateTime.parse(contratoItem.horarioInicioPropuesto!);
    // Se le cambia la fecha de inicio y fin al contratoItem manteniendo la hora

    DateTime horarioInicio = DateTime.parse(contratoItem.horarioInicioPropuesto!);
    DateTime horarioFin = DateTime.parse(contratoItem.horarioFinPropuesto!);

    if(isDate){

      horarioInicio = DateTime(value!.year, value.month, value.day, horarioInicio.hour, horarioInicio.minute);
      horarioFin = DateTime(value.year, value.month, value.day, horarioFin.hour, horarioFin.minute);

      RxList<String> horasDisponiblesNuevaFecha = RxList<String>();
      horasDisponiblesNuevaFecha.assignAll(extraFunctions.onlyForStartTime(fechasConCita, value.toString().split(" ")[0]));

      String horaInicioActual = '${horarioInicio.hour.toString().padLeft(2, '0')}:${horarioInicio.minute.toString().padLeft(2, '0')}';
      String horaFinActual = '${horarioFin.hour.toString().padLeft(2, '0')}:${horarioFin.minute.toString().padLeft(2, '0')}';

      if(horasDisponiblesNuevaFecha.contains(horaInicioActual) || horasDisponiblesNuevaFecha.contains(horaFinActual)){
        snackbarUI.snackbarError('Horario No Disponible', 'Elimina el contrato actual para poder modificar la fecha.');
        contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
        return;
      }
      
      contratoItems[indexContrato].horarioInicioPropuesto = horarioInicio.toString();
      contratoItems[indexContrato].horarioFinPropuesto = horarioFin.toString();

      for (var t in contratoItems[indexContrato].tareasContrato!) {
        DateTime fechaRealizar = DateTime.parse(t.fechaRealizar!);
        t.fechaRealizar = DateTime(value.year, value.month, value.day, fechaRealizar.hour, fechaRealizar.minute).toString();
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

      contratoItems[indexContrato].horarioInicioPropuesto = horarioInicio.toString();
      contratoItems[indexContrato].horarioFinPropuesto = horarioFin.toString();

      double horasContratas = horarioFin.difference(horarioInicio).inMinutes / 60;
      double costoTotal = horasContratas * personaCuidador.salarioCuidador!;

      contratoItems[indexContrato].importeCuidado = costoTotal;

      if((horarioInicio.hour != horarioInicioValide.hour || horarioInicio.minute != horarioInicioValide.minute)
      || (horarioFin.hour != horarioInicioValide.hour || horarioFin.minute != horarioInicioValide.minute)){
      snackbarUI.snackbarSuccess('Hora Modificada Con Exito!', 'Se ha modificado la hora del contrato.');
      contratoItems.refresh();
      contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
      }
      else{
        snackbarUI.snackbarError('No Se Modifico La Hora', 'La hora del contrato sigue siendo la misma.');
      }

    }
    
  }

  void modifyObservaciones(String observaciones, int indexContrato){
    contratoItems[indexContrato].observaciones = observaciones;
    contratoItems.refresh();
    contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
  }

  void modifyTareasContrato(String ediciontext, int indiceTarea, int indexContrato, bool isTitulo){
    if(isTitulo){
      contratoItems[indexContrato].tareasContrato![0].tituloTarea = ediciontext;
    }
    else{
      contratoItems[indexContrato].tareasContrato![0].descripcionTarea = ediciontext;
    }
    contratoItems.refresh();
    contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
  }

  void modifyHorarioTarea(String horario, int indexContrato, int indexTarea){
    int hora = int.parse(horario.padLeft(5, '0').split(":")[0]);
    int minuto = int.parse(horario.split(":")[1]);
    DateTime horarioInicio = DateTime.parse(contratoItems[indexContrato].tareasContrato![indexTarea].fechaRealizar!);
    horarioInicio = DateTime(horarioInicio.year, horarioInicio.month, horarioInicio.day, hora, minuto);
    contratoItems[indexContrato].tareasContrato![indexTarea].fechaRealizar = horarioInicio.toString();
    contratoItems.refresh();
    contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, indexContrato);
  }

  void deleteContratoOrTask(int indexContrato, int indexTarea){
    if(indexTarea == -1){
      contratoItems.removeAt(indexContrato);
      contratoItems.refresh();
      fechasConCita.removeAt(indexContrato);
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date.toString()));
      fechasNoDisponiblesSet.refresh();
      horariosInicialesDisponibles = extraFunctions.onlyForStartTime(fechasConCita, date.toString().split(" ")[0]);
      Get.back();
      snackbarUI.snackbarSuccess('Contrato Eliminado', 'Se ha eliminado el contrato.');
      // contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, 0);
    }
    else{
      contratoItems[indexContrato].tareasContrato!.removeAt(indexTarea);
      contratoItems.refresh();
      horariosForTask.assignAll(extraFunctions.availableTimesForTask(contratoItems[indexContrato].horarioInicioPropuesto!, contratoItems[indexContrato].horarioFinPropuesto!, contratoItems[indexContrato].tareasContrato!));
      horariosForTask.refresh();
      snackbarUI.snackbarSuccess('Tarea Eliminada', 'Se ha eliminado la tarea.');
      // contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, 0);
    }
  }

  // bool valideSaveContratoItem(){

  //   //Validar que existan fechas seleccionadas
  //   if(selectedTimeStart.isEmpty || selectedTimeEnd.isEmpty){
  //     snackbarUI.snackbarError('Contrato sin fecha!', 'Debes seleccionar un horario de inicio y fin.');
  //     return false;
  //   }

  //   // Validar que 

  //   if(selectedTimeStart.isEmpty || selectedTimeEnd.isEmpty){
  //     snackbarUI.snackbarError('Error', 'Debes seleccionar un horario de inicio y fin.');
  //     return false;
  //   }
  //   if(selectedTimeStart.isNotEmpty && selectedTimeEnd.isNotEmpty){
  //     DateTime horarioInicio = extraFunctions.stringToDateTime(selectedTimeStart);
  //     DateTime horarioFin = extraFunctions.stringToDateTime(selectedTimeEnd);
  //     if(horarioInicio.isAfter(horarioFin)){
  //       snackbarUI.snackbarError('Error', 'El horario de inicio no puede ser mayor al horario de fin.');
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  //! METODOS DE PRUEBAS

  void cargarContratosDePrueba() async{

    //Crear lista de contratos fake
    List<ContratoItemModel> contratos = [
      ContratoItemModel(
        idContratoItem: 1,
        horarioInicioPropuesto: '2024-07-10 10:00:00',
        horarioFinPropuesto: '2024-07-10 12:00:00',
        observaciones: 'Observaciones de la cita',
        importeCuidado: personaCuidador.salarioCuidador! * 2,
        tareasContrato: RxList<TareasContratoModel>([
          TareasContratoModel(
            tituloTarea: 'Tarea 1',
            descripcionTarea: 'Descripcion de la tarea 1',
            tipoTarea: 'Tarea',
            fechaRealizar: '2022-10-10 10:00:00',
          ),
          TareasContratoModel(
            tituloTarea: 'Tarea 2',
            descripcionTarea: 'Descripcion de la tarea 2',
            tipoTarea: 'Tarea',
            fechaRealizar: '2022-10-10 10:00:00',
            fechaPospuesta: '2022-10-1 12:00:00',
          ),
        ]),
      ),
      ContratoItemModel(
        idContratoItem: 2,
        horarioInicioPropuesto: '2024-07-10 14:00:00',
        horarioFinPropuesto: '2024-07-10 19:00:00',
        observaciones: 'Observaciones de la cita',
        importeCuidado: personaCuidador.salarioCuidador! * 5,
        tareasContrato: RxList<TareasContratoModel>([
          TareasContratoModel(
            tituloTarea: 'Tarea 1',
            descripcionTarea: 'Descripcion de la tarea 1',
            tipoTarea: 'Tarea',
            fechaRealizar: '2022-10-10 10:00:00',
          ),
        ]),
      ),
      ContratoItemModel(
        idContratoItem: 3,
        horarioInicioPropuesto: '2024-07-11 14:00:00',
        horarioFinPropuesto: '2024-07-11 11:00:00',
        observaciones: 'Observaciones de la cita',
        importeCuidado: personaCuidador.salarioCuidador! * 5,
        tareasContrato: RxList<TareasContratoModel>([
          TareasContratoModel(
            tituloTarea: 'Tarea 1',
            descripcionTarea: 'Descripcion de la tarea 1',
            tipoTarea: 'Tarea',
            fechaRealizar: '2022-10-11 10:00:00',
          ),
        ]),
      ),
    ];
  
    if(contratoItems.isEmpty){
      contratoItems.assignAll(contratos);
      contratoItems.refresh();

      for(ContratoItemModel i in contratos){
        fechasConCita.add(i);
      }
      fechasNoDisponiblesSet.assignAll(extraFunctions.findDatesWithLessThanOneHour(fechasConCita, date.toString()));
      fechasNoDisponiblesSet.refresh();
    }

    if(contratoItems.isNotEmpty){
      // contratoItemList.cbxTimes(contratos.first, 1);
      contratoItemList.mostrarListadofromModalSheet(contratoItems, personaCuidador.persona!.first.avatarImage!, 0);
    }
  
  }

}