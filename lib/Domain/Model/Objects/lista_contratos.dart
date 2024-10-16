import 'dart:convert';

import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:flutter/material.dart';

List<ListaContratos> listaContratosFromJson(String str) => List<ListaContratos>.from(json.decode(str).map((x) => ListaContratos.fromJson(x)));

String listaContratosToJson(List<ListaContratos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaContratos {
    int? idContrato;
    int? idContratoItem;
    DateTime? horarioInicio;
    DateTime? horarioFin;
    PersonaModel? personaCuidador;
    PersonaModel? personaCliente;
    EstatusModel? estatus;
    int? numeroDeTareas;
    double? importeCuidado;
    Color? color;

    ListaContratos({
        this.idContrato,
        this.idContratoItem,
        this.horarioInicio,
        this.horarioFin,
        this.personaCuidador,
        this.personaCliente,
        this.estatus,
        this.numeroDeTareas,
        this.importeCuidado,
        this.color,
    });

    factory ListaContratos.fromJson(Map<String, dynamic> json) => ListaContratos(
        idContrato: json["idContrato"],
        idContratoItem: json["idContratoItem"],
        horarioInicio: json["horarioInicio"] != null ? DateTime.parse(json["horarioInicio"]) : null,
        horarioFin: json["horarioFin"] != null ? DateTime.parse(json["horarioFin"]) : null,
        personaCuidador: json["personaCuidador"] != null ? PersonaModel.fromJson(json["personaCuidador"]) : null,
        personaCliente: json["personaCliente"] != null ? PersonaModel.fromJson(json["personaCliente"]) : null,
        estatus: json["estatus"] != null ? EstatusModel.fromJson(json["estatus"]) : null,
        numeroDeTareas: json["numeroDeTareas"] ?? 0,
        importeCuidado: json["importeCuidado"] ?? 0,
    );


    Map<String, dynamic> toJson() => {
        "idContrato": idContrato,
        "idContratoItem": idContratoItem,
        "horarioInicio": horarioInicio!.toIso8601String(),
        "horarioFin": horarioFin!.toIso8601String(),
        "personaCuidador": personaCuidador!.toJson(),
        "personaCliente": personaCliente!.toJson(),
        "estatus": estatus!.toJson(),
        "numeroDeTareas": numeroDeTareas,
        "importeCuidado": importeCuidado,
    };

}