class EventosContratoModel {

  String? titulo;
  String? fecha;
  String? estatus;
  String? tooltip;

  EventosContratoModel({
    this.titulo,
    this.fecha,
    this.estatus,
    this.tooltip,
  });

  EventosContratoModel.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    fecha = json['fecha'];
    estatus = json['estatus'];
    tooltip = json['tooltip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['fecha'] = fecha;
    data['estatus'] = estatus;
    data['tooltip'] = tooltip;
    return data;
  }

}