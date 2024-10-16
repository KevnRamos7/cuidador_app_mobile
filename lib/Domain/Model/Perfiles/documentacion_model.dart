class DocumentacionModel{

  int? idDocumentacion;
  String? tipoDocumento;
  String? nombreDocumento;
  String? urlDocumento;
  String? fechaEmision;
  String? fechaExpiracion;

  DocumentacionModel({this.idDocumentacion, this.tipoDocumento, this.nombreDocumento, this.urlDocumento, this.fechaEmision, this.fechaExpiracion});

  DocumentacionModel.fromJson(Map<String, dynamic> json){
    idDocumentacion = json['idDocumentacion'];
    tipoDocumento = json['tipoDocumento'];
    nombreDocumento = json['nombreDocumento'];
    urlDocumento = json['urlDocumento'];
    fechaEmision = json['fechaEmision'];
    fechaExpiracion = json['fechaExpiracion'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDocumentacion'] = idDocumentacion;
    data['tipoDocumento'] = tipoDocumento;
    data['nombreDocumento'] = nombreDocumento;
    data['urlDocumento'] = urlDocumento;
    data['fechaEmision'] = fechaEmision;
    data['fechaExpiracion'] = fechaExpiracion;
    return data;
  }

}