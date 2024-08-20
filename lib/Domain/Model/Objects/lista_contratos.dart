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
        idContrato: json["id_contrato"],
        idContratoItem: json["id_contrato_item"],
        horarioInicio: json["horario_inicio"] != null ? DateTime.parse(json["horario_inicio"]) : null,
        horarioFin: json["horario_fin"] != null ? DateTime.parse(json["horario_fin"]) : null,
        personaCuidador: json["persona_cuidador"] != null ? PersonaModel.fromJson(json["persona_cuidador"]) : null,
        personaCliente: json["persona_cliente"] != null ? PersonaModel.fromJson(json["persona_cliente"]) : null,
        estatus: json["estatus"] != null ? EstatusModel.fromJson(json["estatus"]) : null,
        numeroDeTareas: json["numero_de_tareas"] ?? 0,
        importeCuidado: json["importe_cuidado"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id_contrato": idContrato,
        "id_contrato_item": idContratoItem,
        "horario_inicio": horarioInicio!.toIso8601String(),
        "horario_fin": horarioFin!.toIso8601String(),
        "persona_cuidador": personaCuidador,
        "persona_cliente": personaCliente,
        "estatus": estatus,
        "numero_de_tareas": numeroDeTareas,
        "importe_cuidado": importeCuidado,
    };
}