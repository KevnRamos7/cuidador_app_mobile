import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';

class TareasContratoModel{

  int? idTareasContrato;
  String? tituloTarea;
  String? descripcionTarea;
  String? tipoTarea;
  EstatusModel? estatus;
  String? fechaRealizar;
  String? fechaInicio;
  String? fechaFinalizacion;
  String? fechaPospuesta;

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
    idTareasContrato = json['id_tareas_contrato'];
    tituloTarea = json['titulo_tarea'];
    descripcionTarea = json['descripcion_tarea'];
    tipoTarea = json['tipo_tarea'];
    estatus = json['estatus'];
    fechaRealizar = json['fecha_a_realizar'];
    fechaInicio = json['fecha_inicio'];
    fechaFinalizacion = json['fecha_finalizacion'];
    fechaPospuesta = json['fecha_pospuesta'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tareas_contrato'] = idTareasContrato;
    data['titulo_tarea'] = tituloTarea;
    data['descripcion_tarea'] = descripcionTarea;
    data['tipo_tarea'] = tipoTarea;
    data['estatus'] = estatus;
    data['fecha_a_realizar'] = fechaRealizar;
    data['fecha_inicio'] = fechaInicio;
    data['fecha_finalizacion'] = fechaFinalizacion;
    data['fecha_pospuesta'] = fechaPospuesta;
    return data;
  }

}