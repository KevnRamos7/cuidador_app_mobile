import 'package:flutter/material.dart';

/// Modelo de datos para un menú.
class MenuModel {
  int? idMenu;
  int? estatusId;
  String? nombreMenu;
  String? descripcionMenu;
  String? rutaMenu;
  String? endpoint;
  IconData? icono;

  /// Constructor de la clase MenuModel.
  MenuModel({
    this.idMenu,
    this.estatusId,
    this.nombreMenu,
    this.descripcionMenu,
    this.rutaMenu,
    this.endpoint,
    this.icono,
  });

  /// Crea una instancia de MenuModel a partir de un Map JSON.
  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      idMenu: json['idMenu'],
      estatusId: json['estatusId'],
      nombreMenu: json['nombreMenu'],
      descripcionMenu: json['descripcionMenu'],
      rutaMenu: json['rutaMenu'],
      endpoint: json['endpoint'],
    );
  }

  /// Convierte una instancia de MenuModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'idMenu': idMenu,
      'estatusId': estatusId,
      'nombreMenu': nombreMenu,
      'descripcionMenu': descripcionMenu,
      'rutaMenu': rutaMenu,
      'endpoint': endpoint,
    };
  }


}
