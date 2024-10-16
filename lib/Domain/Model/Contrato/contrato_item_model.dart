import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:get/get.dart';

class ContratoItemModel{

  int? idContratoItem;
  EstatusModel? estatus;
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
      idContratoItem: json['idContratoItem'],
      estatus: json['estatus'] != null ? EstatusModel.fromJson(json['estatus']) : null,
      observaciones: json['observaciones'],
      horarioInicioPropuesto: DateTime.tryParse(json['horarioInicioPropuesto'].toString().replaceAll('T', " ")),
      horarioFinPropuesto: DateTime.tryParse(json['horarioFinPropuesto'].toString().replaceAll('T', " ")),
      fechaAceptacion: DateTime.tryParse(json['fechaAceptacion'].toString().replaceAll('T', " ")),
      fechaInicioCuidado: DateTime.tryParse(json['fechaInicioCuidado'].toString().replaceAll('T', " ")),
      fechaFinCuidado: DateTime.tryParse(json['fechaFinCuidado'].toString().replaceAll('T', " ")),
      importeCuidado: json['importeTotal'] != null ? json['importeTotal'].toDouble() : 0.0,
      tareasContrato: json['tareasContratos'] != null ? (json['tareasContratos'] as List).map((i) => TareasContratoModel.fromJson(i)).toList().obs : null,
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idContratoItem'] = idContratoItem;
    data['estatus'] = estatus!.toJson();
    data['observaciones'] = observaciones;
    data['horarioInicioPropuesto'] = horarioInicioPropuesto?.toIso8601String();
    data['horarioFinPropuesto'] = horarioFinPropuesto?.toIso8601String();
    data['fechaAceptacion'] = fechaAceptacion?.toIso8601String();
    data['fechaInicioCuidado'] = fechaInicioCuidado?.toIso8601String();
    data['fechaFinCuidado'] = fechaFinCuidado?.toIso8601String();
    data['importeCuidado'] = importeCuidado;
    data['tareasContrato'] = tareasContrato!.map((i) => i.toJson()).toList();
    return data;
  }

}