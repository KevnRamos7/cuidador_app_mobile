// To parse this JSON data, do
//
//     final estatusContratoItemCliente = estatusContratoItemClienteFromJson(jsonString);

import 'dart:convert';

EstatusContratoItemCliente estatusContratoItemClienteFromJson(String str) => EstatusContratoItemCliente.fromJson(json.decode(str));

class EstatusContratoItemCliente {
    DateTime? horarioInicioPropuesto;
    DateTime? horarioFinPropuesto;
    double? importeTotal;
    int? tiempoContratado;
    DateTime? fechaAceptacion;
    DateTime? fechaInicioCuidado;
    DateTime? fechaFinCuidado;
    List<EstatusTarea>? estatusTareas;

    EstatusContratoItemCliente({
        this.horarioInicioPropuesto,
        this.horarioFinPropuesto,
        this.importeTotal,
        this.tiempoContratado,
        this.fechaAceptacion,
        this.fechaInicioCuidado,
        this.fechaFinCuidado,
        this.estatusTareas,
    });

    factory EstatusContratoItemCliente.fromJson(Map<String, dynamic> json) => EstatusContratoItemCliente(
        horarioInicioPropuesto: DateTime.parse(json["horarioInicioPropuesto"]),
        horarioFinPropuesto: DateTime.parse(json["horarioFinPropuesto"]),   
        importeTotal: json["importeTotal"].toDouble() ?? 0.0,
        tiempoContratado: json["tiempoContratado"],
        fechaAceptacion: DateTime.parse(json["fechaAceptacion"]),
        fechaInicioCuidado: DateTime.parse(json["fechaInicioCuidado"]),
        fechaFinCuidado: DateTime.parse(json["fechaFinCuidado"]),
        estatusTareas: List<EstatusTarea>.from(json["estatusTareas"].map((x) => EstatusTarea.fromJson(x))),
    );
}

class EstatusTarea {
    String? tituloTarea;
    String? descripcionTarea;
    int? estatusId;
    String? nombreEstatus;
    DateTime? fechaEstatusTarea;

    EstatusTarea({
        this.tituloTarea,
        this.descripcionTarea,
        this.estatusId,
        this.nombreEstatus,
        this.fechaEstatusTarea,
    });

    factory EstatusTarea.fromJson(Map<String, dynamic> json) => EstatusTarea(
        tituloTarea: json["tituloTarea"],
        descripcionTarea: json["descripcionTarea"],
        estatusId: json["estatusId"],
        nombreEstatus: json["nombreEstatus"],
        fechaEstatusTarea: DateTime.parse(json["fechaEstatusTarea"]),
    );
}
