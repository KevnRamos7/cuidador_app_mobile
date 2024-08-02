import 'package:cuidador_app_mobile/Data/Response/ListContratos/list_contratos_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/build_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Domain/Model/Contrato/tareas_contrato_model.dart';
import '../../../../Domain/Model/Objects/eventos_contrato_model.dart';
import '../../../../Domain/Model/Objects/lista_contratos.dart';

class ListContratoController extends GetxController{

  BuildTimeline buildTimeline = BuildTimeline();
  List<TimelineTile> timeLineList = [];
  ListContratosResponse listContratosResponse = ListContratosResponse();

  RxList<ListaContratos> contratos = <ListaContratos>[].obs;
  RxList<ListaContratos> contratosFiltrados = <ListaContratos>[].obs;
  DateTime fechaSeleccionada = DateTime.now();
  List<EventosContratoModel> eventos = [
    EventosContratoModel(titulo: 'Contrato aceptado!', fecha: 'Viernes 16 de julio a las 08:09', estatus: 'Finalizado'),
    EventosContratoModel(titulo: 'Cuidador en camino', fecha: 'Martes 22 de julio a las 12:00', estatus: 'En curso'),
    EventosContratoModel(titulo: 'Inicio de contrato', fecha: 'Martes 22 de julio a las 13:00', estatus: 'Inactivo'),
    EventosContratoModel(titulo: 'Tarea: Limpiar habitación', fecha: 'Martes 22 de julio a las 13:20', estatus: 'Inactivo'),
    EventosContratoModel(titulo: 'Tarea: Limpiar habitación', fecha: 'Martes 22 de julio a las 13:20', estatus: 'Inactivo'),
    EventosContratoModel(titulo: 'Fin de contrato', fecha: 'Martes 22 de julio a las 18:20', estatus: 'Inactivo'),
  ];

  Rx<ContratoModel> contrato = ContratoModel(
    personaCuidador: PersonaModel(
      nombre: 'Juan',
      apellidoMaterno: 'Perez',
      apellidoPaterno: 'Lopez',
      avatarImage: 'https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109'
    ),
    contratoItem:  RxList<ContratoItemModel>(
      [
        ContratoItemModel(
          horarioInicioPropuesto: DateTime.now(),
          horarioFinPropuesto: DateTime.now(),
          importeCuidado: 300,
          observaciones: 'Cuidarlo Bien',
          tareasContrato: RxList<TareasContratoModel>(
            [
              TareasContratoModel(
                tituloTarea: 'Limpiar habitación',
                descripcionTarea: 'Limpiar la habitación del adulto mayor',
                fechaRealizar: DateTime.now(),
              ),
              TareasContratoModel(
                tituloTarea: 'Lavar ropa',
                descripcionTarea: 'Lavar la ropa del adulto mayor',
                fechaRealizar: DateTime.now(),
              ),
              TareasContratoModel(
                tituloTarea: 'Cocinar',
                descripcionTarea: 'Cocinar para el adulto mayor',
                fechaRealizar: DateTime.now()
              ),
            ]
          )
        ),
        ContratoItemModel(
          horarioInicioPropuesto: DateTime.now(),
          horarioFinPropuesto: DateTime.now(),
          importeCuidado: 300,
          observaciones: 'Cuidarlo Bien',
          tareasContrato: RxList<TareasContratoModel>(
            [
              TareasContratoModel(
                tituloTarea: 'Limpiar habitación',
                descripcionTarea: 'Limpiar la habitación del adulto mayor',
                fechaRealizar: DateTime.now(),
              ),
              TareasContratoModel(
                tituloTarea: 'Lavar ropa',
                descripcionTarea: 'Lavar la ropa del adulto mayor',
                fechaRealizar: DateTime.now(),
              ),
              TareasContratoModel(
                tituloTarea: 'Cocinar',
                descripcionTarea: 'Cocinar para el adulto mayor',
                fechaRealizar: DateTime.now()
              ),
            ]
          )
        )
      ]
    ),
  ).obs;

  @override
  void onInit() async{
    super.onInit();
    await getContratosPorCliente();
    timeLineList = buildTimeline.construirLista(eventos);
  }

  Future<void> getContratosPorCliente() async{
    contratos.assignAll(await listContratosResponse.getListaContratos());
    // fechaSeleccionada = contratos[0].fechaPrimerContrato!;
    for(ListaContratos c in contratos){
      c.color = asignarColor(c.estatus?.nombre ?? '');
    }
    contratos.refresh();
    contratosFiltrados.assignAll(contratos.where((element) => 
    element.fechaPrimerContrato!.day == fechaSeleccionada.day &&
    element.fechaPrimerContrato!.month == fechaSeleccionada.month &&
    element.fechaPrimerContrato!.year == fechaSeleccionada.year
    ).toList());
    contratosFiltrados.refresh();
    update();
  }

  Color asignarColor(String estatus){
    switch (estatus.toUpperCase()) {
      case 'NO ACEPTADA':
        return Colors.black;
      case 'ACEPTADA':
        return Colors.green;
      case 'EN CURSO':
        return Colors.orange[700]!;
      case 'RECHAZADA':
        return Colors.red[900]!;
      default:
        return Colors.blueGrey;
    }
  }

  void changeFechaSeleccionada(DateTime fecha){
    fechaSeleccionada = fecha;
    contratosFiltrados.assignAll(contratos.where((element) => 
    element.fechaPrimerContrato!.day == fechaSeleccionada.day &&
    element.fechaPrimerContrato!.month == fechaSeleccionada.month &&
    element.fechaPrimerContrato!.year == fechaSeleccionada.year
    ).toList());
    contratosFiltrados.refresh();
    update();
  }

}