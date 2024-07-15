class DocumentacionModel{

  int? idDocumentacion;
  String? tipoDocumento;
  String? nombreDocumento;
  String? urlDocumento;
  String? fechaEmision;
  String? fechaExpiracion;

  DocumentacionModel({this.idDocumentacion, this.tipoDocumento, this.nombreDocumento, this.urlDocumento, this.fechaEmision, this.fechaExpiracion});

  DocumentacionModel.fromJson(Map<String, dynamic> json){
    idDocumentacion = json['id_documentacion'];
    tipoDocumento = json['tipo_documento'];
    nombreDocumento = json['nombre_documento'];
    urlDocumento = json['url_documento'];
    fechaEmision = json['fecha_emision'];
    fechaExpiracion = json['fecha_expiracion'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_documentacion'] = idDocumentacion;
    data['tipo_documento'] = tipoDocumento;
    data['nombre_documento'] = nombreDocumento;
    data['url_documento'] = urlDocumento;
    data['fecha_emision'] = fechaEmision;
    data['fecha_expiracion'] = fechaExpiracion;
    return data;
  }

}