/// Modelo de datos para un menú.
class MenuModel {
  int? idMenu;
  int? estatusId;
  String? nombreMenu;
  String? descripcionMenu;
  String? rutaMenu;
  String? endpoint;

  /// Constructor de la clase MenuModel.
  MenuModel({
    this.idMenu,
    this.estatusId,
    this.nombreMenu,
    this.descripcionMenu,
    this.rutaMenu,
    this.endpoint,
  });

  /// Crea una instancia de MenuModel a partir de un Map JSON.
  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      idMenu: json['id_menu'],
      estatusId: json['estatus_id'],
      nombreMenu: json['nombre_menu'],
      descripcionMenu: json['descripcion_menu'],
      rutaMenu: json['ruta_menu'],
      endpoint: json['endpoint'],
    );
  }

  /// Convierte una instancia de MenuModel a un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id_menu': idMenu,
      'estatus_id': estatusId,
      'nombre_menu': nombreMenu,
      'descripcion_menu': descripcionMenu,
      'ruta_menu': rutaMenu,
      'endpoint': endpoint,
    };
  }
}
