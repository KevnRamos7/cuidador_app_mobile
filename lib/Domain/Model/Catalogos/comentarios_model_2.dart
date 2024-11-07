// To parse this JSON data, do
//
//     final comentariosModel = comentariosModelFromJson(jsonString);

import 'dart:convert';

List<ComentariosModel2> comentariosModelFromJson(String str) => List<ComentariosModel2>.from(json.decode(str).map((x) => ComentariosModel2.fromJson(x)));


class ComentariosModel2 {
    int? idComentarios;
    int? personaReceptorid;
    int? personaEmisorid;
    int? calificacion;
    String? comentario;
    DateTime? fechaRegistro;
    int? usuarioRegistro;
    dynamic fechaModificacion;
    dynamic usuarioModifico;

    ComentariosModel2({
        this.idComentarios,
        this.personaReceptorid,
        this.personaEmisorid,
        this.calificacion,
        this.comentario,
        this.fechaRegistro,
        this.usuarioRegistro,
        this.fechaModificacion,
        this.usuarioModifico,
    });

    factory ComentariosModel2.fromJson(Map<String, dynamic> json) => ComentariosModel2(
        idComentarios: json["idComentarios"],
        personaReceptorid: json["personaReceptorid"],
        personaEmisorid: json["personaEmisorid"],
        calificacion: json["calificacion"],
        comentario: json["comentario"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        usuarioRegistro: json["usuarioRegistro"],
        fechaModificacion: json["fechaModificacion"],
        usuarioModifico: json["usuarioModifico"],
    );

}
