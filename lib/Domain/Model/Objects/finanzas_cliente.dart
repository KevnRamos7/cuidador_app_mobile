import 'package:cuidador_app_mobile/Domain/Model/Catalogos/TransaccionesSaldo.dart';

import '../Catalogos/metodo_pago_usuario.dart';

class FinanzasCliente{

  int? saldoId;
  double? saldoActual;
  List<MetodoPagoUsuario>? metodoPagoUsuario = [];
  List<Transaccionessaldo>? transacciones = [];


  FinanzasCliente({
    this.saldoId,
    this.saldoActual,
    this.metodoPagoUsuario,
    this.transacciones
  });
  
  FinanzasCliente.fromJson(Map<String, dynamic> json) {
    saldoId = json['saldoId'];
    saldoActual = json['saldoActual'];
    metodoPagoUsuario = json['metodoPagoUsuario'] != null ? json['metodoPagoUsuario'].map<MetodoPagoUsuario>((e) => MetodoPagoUsuario.fromJson(e)).toList() : [];
    transacciones = json['transacciones'] != null ? json['transacciones'].map<Transaccionessaldo>((e) => Transaccionessaldo.fromJson(e)).toList() : [];
  }

}