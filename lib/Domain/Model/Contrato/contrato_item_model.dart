import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:get/get.dart';

class ContratoItemModel{

  int? idContratoItem;
  String? estatus;
  String? observaciones;
  String? fechaSolicitaCliente;
  String? fechaInicioContrato;
  String? fechaFinContrato;
  String? fechaCambioEstatus;
  String? fechaIncioCuidado;
  String? fechaFinCuidado;
  RxList<TareasContratoModel>? tareasContrato;

  ContratoItemModel({this.idContratoItem, this.estatus, this.observaciones, this.fechaSolicitaCliente, this.fechaInicioContrato, this.fechaFinContrato, this.fechaCambioEstatus, this.fechaIncioCuidado, this.fechaFinCuidado, this.tareasContrato});

  factory ContratoItemModel.fromJson(Map<String, dynamic> json){
    return ContratoItemModel(
      idContratoItem: json['id_contrato_item'],
      estatus: json['estatus'],
      observaciones: json['observaciones'],
      fechaSolicitaCliente: json['fecha_solicita_cliente'],
      fechaInicioContrato: json['fecha_inicio_contrato'],
      fechaFinContrato: json['fecha_fin_contrato'],
      fechaCambioEstatus: json['fecha_cambio_estatus'],
      fechaIncioCuidado: json['fecha_incio_cuidado'],
      fechaFinCuidado: json['fecha_fin_cuidado'],
      tareasContrato: json['tareas_contrato'] != null ? (json['tareas_contrato'] as List).map((i) => TareasContratoModel.fromJson(i)).toList().obs : null,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id_contrato_item': idContratoItem,
      'estatus': estatus,
      'observaciones': observaciones,
      'fecha_solicita_cliente': fechaSolicitaCliente,
      'fecha_inicio_contrato': fechaInicioContrato,
      'fecha_fin_contrato': fechaFinContrato,
      'fecha_cambio_estatus': fechaCambioEstatus,
      'fecha_incio_cuidado': fechaIncioCuidado,
      'fecha_fin_cuidado': fechaFinCuidado,
      'tareas_contrato': tareasContrato!.map((e) => e.toJson()).toList(),
    };
  }

}