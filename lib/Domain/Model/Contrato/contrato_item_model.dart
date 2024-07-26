import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:get/get.dart';

class ContratoItemModel{

  int? idContratoItem;
  String? estatus;
  String? observaciones;
  DateTime? horarioInicioPropuesto;
  DateTime? horarioFinPropuesto;
  DateTime? fechaAceptacion;
  DateTime? fechaInicioCuidado;
  DateTime? fechaFinCuidado;
  double? importeCuidado;
  RxList<TareasContratoModel>? tareasContrato;

  ContratoItemModel({this.idContratoItem, this.estatus, this.observaciones, this.horarioInicioPropuesto, this.horarioFinPropuesto, this.fechaAceptacion, this.fechaInicioCuidado, this.fechaFinCuidado, this.importeCuidado, this.tareasContrato});

  factory ContratoItemModel.fromJson(Map<String, dynamic> json){
    return ContratoItemModel(
      idContratoItem: json['id_contrato_item'],
      estatus: json['estatus'],
      observaciones: json['observaciones'],
      horarioInicioPropuesto: DateTime.tryParse(json['horario_inicio_propuesto'].toString().replaceAll('T', " ")),
      horarioFinPropuesto: DateTime.tryParse(json['horario_fin_propuesto'].toString().replaceAll('T', " ")),
      fechaAceptacion: DateTime.tryParse(json['fecha_aceptacion'].toString().replaceAll('T', " ")),
      fechaInicioCuidado: DateTime.tryParse(json['fecha_inicio_cuidado'].toString().replaceAll('T', " ")),
      fechaFinCuidado: DateTime.tryParse(json['fecha_fin_cuidado'].toString().replaceAll('T', " ")),
      importeCuidado: json['importe_cuidado'] != null ? json['importe_cuidado'].toDouble() : 0.0,
      tareasContrato: json['tareas_contrato'] != null ? (json['tareas_contrato'] as List).map((i) => TareasContratoModel.fromJson(i)).toList().obs : null,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id_contrato_item': idContratoItem,
      'estatus': estatus,
      'observaciones': observaciones,
      'horario_inicio_propuesto': horarioInicioPropuesto,
      'horario_fin_propuesto': horarioFinPropuesto,
      'fecha_aceptacion': fechaAceptacion,
      'fecha_cambio_estatus': fechaInicioCuidado,
      'fecha_inicio_cuidado': fechaInicioCuidado,
      'fecha_fin_cuidado': fechaFinCuidado,
      'tareas_contrato': tareasContrato!.map((e) => e.toJson()).toList(),
    };
  }

}