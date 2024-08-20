class EventosContratoModel {

  int? id;
  bool? esTarea;
  String? titulo;
  DateTime? fecha;
  String? estatus;
  String? tooltip;

  EventosContratoModel({
    this.id,
    this.esTarea,
    this.titulo,
    this.fecha,
    this.estatus,
    this.tooltip,
  });

  EventosContratoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    esTarea = json['esTarea'];
    titulo = json['titulo'];
    fecha = json['fecha'] != null ? DateTime.parse(json['fecha']) : null;
    estatus = json['estatus'];
    tooltip = json['tooltip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['esTarea'] = esTarea;
    data['titulo'] = titulo;
    data['fecha'] = fecha?.toIso8601String();
    data['estatus'] = estatus;
    data['tooltip'] = tooltip;
    return data;
  }

}