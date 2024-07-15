class EstatusModel{

  int? idEstatus;
  String? codigo;
  String? nombre;
  String? color;

  EstatusModel({this.idEstatus, this.codigo, this.nombre, this.color});

  EstatusModel.fromJson(Map<String, dynamic> json){
    idEstatus = json['id_estatus'];
    codigo = json['codigo'];
    nombre = json['nombre'];
    color = json['color'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_estatus'] = idEstatus;
    data['codigo'] = codigo;
    data['nombre'] = nombre;
    data['color'] = color;
    return data;
  }

}