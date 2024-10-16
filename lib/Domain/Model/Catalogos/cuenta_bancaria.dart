import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';

class CuentaBancaria{

  int? idCuentaBancaria;
  UsuarioModel? usuario;
  int? numeroCuenta;
  int? clabeInterbancaria;
  String? nombreBanco;

  CuentaBancaria({
    this.idCuentaBancaria,
    this.usuario,
    this.numeroCuenta,
    this.clabeInterbancaria,
    this.nombreBanco
  });

  factory CuentaBancaria.fromJson(Map<String, dynamic> json) => CuentaBancaria(
    idCuentaBancaria: json['idCuentabancaria'],
    // usuario: json['Usuario'] != null ? UsuarioModel.fromJson(json['Usuario']) : null,
    numeroCuenta: json['numeroCuenta'],
    clabeInterbancaria: json['clabeInterbancaria'],
    nombreBanco: json['nombreBanco']
  );

  Map<String, dynamic> toJson() => {
    'idCuentaBancaria': idCuentaBancaria,
    'usuario': usuario!.toJson(),
    'numeroCuenta': numeroCuenta,
    'clabeInterbancaria': clabeInterbancaria,
    'nombreBanco': nombreBanco
  };

}