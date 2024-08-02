import 'dart:convert';

import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:flutter/material.dart';

List<ListaContratos> listaContratosFromJson(String str) => List<ListaContratos>.from(json.decode(str).map((x) => ListaContratos.fromJson(x)));

String listaContratosToJson(List<ListaContratos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaContratos {
    int? idContrato;
    PersonaModel? personaCuidador;
    PersonaModel? personaCliente;
    EstatusModel? estatus;
    int? numeroDeContratos;
    int? numeroDeTareas;
    int? costoTotal;
    DateTime? fechaPrimerContrato;
    DateTime? fechaUltimoContrato;
    Color? color;

    ListaContratos({
        this.idContrato,
        this.personaCuidador,
        this.personaCliente,
        this.estatus,
        this.numeroDeContratos,
        this.numeroDeTareas,
        this.costoTotal,
        this.fechaPrimerContrato,
        this.fechaUltimoContrato,
        this.color,
    });

    factory ListaContratos.fromJson(Map<String, dynamic> json) => ListaContratos(
        idContrato: json["id_contrato"],
        personaCuidador: json["persona_cuidador"] != null ? PersonaModel.fromJson(json["persona_cuidador"]) : null,
        personaCliente: json["persona_cliente"] != null ? PersonaModel.fromJson(json["persona_cliente"]) : null,
        estatus: json["estatus"] != null ? EstatusModel.fromJson(json["estatus"]) : null,
        numeroDeContratos: json["numero_de_contratos"],
        numeroDeTareas: json["numero_de_tareas"],
        costoTotal: json["costo_total"],
        fechaPrimerContrato: DateTime.parse(json["fecha_primer_contrato"]),
        fechaUltimoContrato: DateTime.parse(json["fecha_ultimo_contrato"]),
    );

    Map<String, dynamic> toJson() => {
        "id_contrato": idContrato,
        "persona_cuidador": personaCuidador,
        "persona_cliente": personaCliente,
        "estatus": estatus,
        "numero_de_contratos": numeroDeContratos,
        "numero_de_tareas": numeroDeTareas,
        "costo_total": costoTotal,
        "fecha_primer_contrato": fechaPrimerContrato,
        "fecha_ultimo_contrato": fechaUltimoContrato,
    };
}