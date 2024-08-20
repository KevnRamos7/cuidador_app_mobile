import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';

class TareasContratoModel{

  int? idTareasContrato;
  String? tituloTarea;
  String? descripcionTarea;
  String? tipoTarea;
  int? estatus;
  DateTime? fechaRealizar;
  DateTime? fechaInicio;
  DateTime? fechaFinalizacion;
  DateTime? fechaPospuesta;

  TareasContratoModel({
    this.idTareasContrato, 
    this.tituloTarea, 
    this.descripcionTarea, 
    this.tipoTarea, 
    this.estatus, 
    this.fechaRealizar, 
    this.fechaInicio, 
    this.fechaFinalizacion, 
    this.fechaPospuesta
  });

  TareasContratoModel.fromJson(Map<String, dynamic> json){
    idTareasContrato = json['idTareas'];
    tituloTarea = json['tituloTarea'];
    descripcionTarea = json['descripcionTarea'];
    tipoTarea = json['tipoTarea'];
    estatus = json['estatusId'];
    fechaRealizar = DateTime.tryParse(json['fechaARealizar'].toString().replaceAll('T', " "));
    fechaInicio = DateTime.tryParse(json['fechaInicio'].toString().replaceAll('T', " "));
    fechaFinalizacion = DateTime.tryParse(json['fechaFinalizacion'].toString().replaceAll('T', " "));
    fechaPospuesta = DateTime.tryParse(json['fechaPospuesta'].toString().replaceAll('T', " "));
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tareas_contrato'] = idTareasContrato;
    data['tituloTarea'] = tituloTarea;
    data['descripcionTarea'] = descripcionTarea;
    data['tipoTarea'] = tipoTarea;
    data['estatus'] = estatus;
    data['fechaARealizar'] = fechaRealizar?.toIso8601String() ?? '';
    data['fecha_inicio'] = fechaInicio?.toIso8601String() ?? '';
    data['fecha_finalizacion'] = fechaFinalizacion?.toIso8601String() ?? '';
    data['fecha_pospuesta'] = fechaPospuesta?.toIso8601String() ?? '';
    return data;
  }

}