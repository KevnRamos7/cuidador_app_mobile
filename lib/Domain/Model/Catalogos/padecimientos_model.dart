class PadecimientosModel {

  int? idPadecimiento;
  String? nombre;
  String? descripcion;
  String? padeceDesde;

  PadecimientosModel({
    this.idPadecimiento,
    this.nombre,
    this.descripcion,
    this.padeceDesde
  });

  factory PadecimientosModel.fromJson(Map<String, dynamic> json) {
    return PadecimientosModel(
      idPadecimiento: json['idPadecimiento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      padeceDesde: json['padeceDesde']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPadecimiento': idPadecimiento,
      'nombre': nombre,
      'descripcion': descripcion,
      'padeceDesde': padeceDesde
    };
  }

}