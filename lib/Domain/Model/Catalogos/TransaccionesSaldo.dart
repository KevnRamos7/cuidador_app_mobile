class Transaccionessaldo{

  int? idTransaccion;
  int? saldoId;
  String? conceptoTransaccion;
  int? metodoPagoId;
  String? tipoMovimiento;
  DateTime? fechaTransaccion;
  double? importeTransaccion;
  double? saldoActual;
  double? saldoAnterior;

  Transaccionessaldo({
    this.idTransaccion,
    this.saldoId,
    this.conceptoTransaccion,
    this.metodoPagoId,
    this.tipoMovimiento,
    this.fechaTransaccion,
    this.importeTransaccion,
    this.saldoActual,
    this.saldoAnterior
  });

  Transaccionessaldo.fromJson(Map<String, dynamic> json){
    idTransaccion = json['idTransaccion'];
    saldoId = json['saldoId'];
    conceptoTransaccion = json['conceptoTransaccion'];
    metodoPagoId = json['metodoPagoId'];
    tipoMovimiento = json['tipoMovimiento'];
    fechaTransaccion = json['fechaTransaccion'] != null ? DateTime.parse(json['fechaTransaccion']) : null;
    importeTransaccion = json['importeTransaccion'];
    saldoActual = json['saldoActual'];
    saldoAnterior = json['saldoAnterior'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTransaccion'] = this.idTransaccion;
    data['saldoId'] = this.saldoId;
    data['conceptoTransaccion'] = this.conceptoTransaccion;
    data['metodoPagoId'] = this.metodoPagoId;
    data['tipoMovimiento'] = this.tipoMovimiento;
    data['fechaTransaccion'] = this.fechaTransaccion;
    data['importeTransaccion'] = this.importeTransaccion;
    data['saldoActual'] = this.saldoActual;
    data['saldoAnterior'] = this.saldoAnterior;
    return data;
  }

}