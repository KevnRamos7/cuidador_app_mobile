
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/cuenta_bancaria.dart';
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/salario_cuidador.dart';

import '../Catalogos/movimiento_cuenta.dart';

class FinanzasCuidador{

    int? saldoId;
    double? saldoActual;
    double? saldoRetirado;
    SalarioCuidador? salarioCuidador;
    CuentaBancaria? cuentaBancaria;
    List<MovimientoCuenta>? movimientos = [];

    FinanzasCuidador({
      this.saldoId,
      this.saldoActual,
      this.saldoRetirado,
      this.salarioCuidador,
      this.cuentaBancaria,
      this.movimientos
    });

    FinanzasCuidador.fromJson(Map<String, dynamic> json) {
      saldoId = json['saldoId'];
      saldoActual = json['saldoActual'];
      saldoRetirado = json['saldoRetirado'];
      salarioCuidador = json['salarioCuidador'] != null ? SalarioCuidador.fromJson(json['salarioCuidador']) : SalarioCuidador();
      cuentaBancaria = json['cuentaBancaria'] != null ? CuentaBancaria.fromJson(json['cuentaBancaria']) : CuentaBancaria();
      movimientos = json['movimientoCuenta'] != null ? json['movimientoCuenta'].map<MovimientoCuenta>((e) => MovimientoCuenta.fromJson(e)).toList() : [];
    }

}