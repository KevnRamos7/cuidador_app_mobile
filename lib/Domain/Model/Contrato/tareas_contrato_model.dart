class TareasContratoModel{

  int? idTareasContrato;
  String? tituloTarea;
  String? descripcionTarea;
  String? tipoTarea;
  String? estatus;
  String? motivoCancelacion;
  String? fechaInicio;
  String? fechaFin;
  String? ultimaFechaPospuesta;

  TareasContratoModel({this.idTareasContrato, this.tituloTarea, this.descripcionTarea, this.tipoTarea, this.estatus, this.motivoCancelacion, this.fechaInicio, this.fechaFin, this.ultimaFechaPospuesta});

  TareasContratoModel.fromJson(Map<String, dynamic> json){
    idTareasContrato = json['id_tareas_contrato'];
    tituloTarea = json['titulo_tarea'];
    descripcionTarea = json['descripcion_tarea'];
    tipoTarea = json['tipo_tarea'];
    estatus = json['estatus'];
    motivoCancelacion = json['motivo_cancelacion'];
    fechaInicio = json['fecha_inicio'];
    fechaFin = json['fecha_fin'];
    ultimaFechaPospuesta = json['ultima_fecha_pospuesta'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tareas_contrato'] = idTareasContrato;
    data['titulo_tarea'] = tituloTarea;
    data['descripcion_tarea'] = descripcionTarea;
    data['tipo_tarea'] = tipoTarea;
    data['estatus'] = estatus;
    data['motivo_cancelacion'] = motivoCancelacion;
    data['fecha_inicio'] = fechaInicio;
    data['fecha_fin'] = fechaFin;
    data['ultima_fecha_pospuesta'] = ultimaFechaPospuesta;
    return data;
  }

}