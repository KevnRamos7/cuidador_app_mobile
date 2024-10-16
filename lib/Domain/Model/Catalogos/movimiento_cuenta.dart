class MovimientoCuenta{

  int? idMovimientoCuenta;
  int? cuentaBancariaId;
  String? conceptoMovimiento;
  String? tipoMovimiento;
  double? numeroSeguimientoBanco;
  DateTime? fechaMovimiento;
  double? importeMovimiento;
  double? saldoActual;
  double? saldoAnterior;

  MovimientoCuenta({
    this.idMovimientoCuenta,
    this.cuentaBancariaId,
    this.conceptoMovimiento,
    this.tipoMovimiento,
    this.numeroSeguimientoBanco,
    this.fechaMovimiento,
    this.importeMovimiento,
    this.saldoActual,
    this.saldoAnterior
  });

  factory MovimientoCuenta.fromJson(Map<String, dynamic> json) => MovimientoCuenta(
    idMovimientoCuenta: json['idMovimientoCuenta'],
    cuentaBancariaId: json['cuentaBancariaId'],
    conceptoMovimiento: json['conceptoMovimiento'],
    tipoMovimiento: json['tipoMovimiento'],
    numeroSeguimientoBanco: json['numeroSeguimientoBanco'] != null ? json['numeroSeguimientoBanco'].toDouble() : 0.0,
    fechaMovimiento: json['fechaMovimiento'] != null ? DateTime.parse(json['fechaMovimiento']) : null,
    importeMovimiento: json['importeMovimiento'] != null ? json['importeMovimiento'].toDouble() : 0.0,
    saldoActual: json['saldoActual'] != null ? json['saldoActual'].toDouble() : 0.0,
    saldoAnterior: json['saldoAnterior'] != null ? json['saldoAnterior'].toDouble()  : 0.0
  );

  Map<String, dynamic> toJson() => {
    'idMovimientoCuenta': idMovimientoCuenta,
    'cuentaBancariaId': cuentaBancariaId,
    'conceptoMovimiento': conceptoMovimiento,
    'tipoMovimiento': tipoMovimiento,
    'numeroSeguimientoBanco': numeroSeguimientoBanco,
    'fechaMovimiento': fechaMovimiento,
    'importeMovimiento': importeMovimiento,
    'saldoActual': saldoActual,
    'saldoAnterior': saldoAnterior
  };

}