import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/build_timeline.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Domain/Model/Contrato/tareas_contrato_model.dart';
import '../../../../Domain/Model/Objects/eventos_contrato_model.dart';

class ListContratoController extends GetxController{

  BuildTimeline buildTimeline = BuildTimeline();
  List<TimelineTile> timeLineList = [];

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
      apellidoPaterno: 'Lopez'
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
  void onInit() {
    super.onInit();
    timeLineList = buildTimeline.construirLista(eventos);
  }



}