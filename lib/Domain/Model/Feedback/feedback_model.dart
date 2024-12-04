import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';

class FeedbackModel {

  int? idFeedback;
  UsuarioModel? usuarioRemitente;
  String? categoria;
  String? cuerpo;
  String? fecha;
  String? fechaResolucion;
  int? estatus;

  FeedbackModel({
    this.idFeedback,
    this.usuarioRemitente,
    this.categoria,
    this.cuerpo,
    this.fecha,
    this.fechaResolucion,
    this.estatus
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      idFeedback: json['idFeedback'],
      // usuarioRemitente: UsuarioModel.fromJson(json['usuarioRemitente']),
      categoria: json['categoria'],
      cuerpo: json['cuerpo'],
      fecha: json['fecha'],
      estatus: json['estatusId'],
      fechaResolucion: json['fechaResolucion'],
      // estatus: EstatusModel.fromJson(json['estatus'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFeedback': idFeedback,
      'usuarioRemitente': usuarioRemitente!.toJson(),
      'categoria': categoria,
      'cuerpo': cuerpo,
      'fecha': fecha,
      'fechaResolucion': fechaResolucion,
      'estatus': estatus!
    };
  }

  
}