

import 'dart:convert';

import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContratoRequest extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> saveContratoInDB(ContratoModel contrato) async{

    String url = '${ConnectionString.connectionString}ContratoItem/guardarContrato';
    Map<String, dynamic> jsonRequest = {
      'persona_cuidador_id' : 6, //contrato.personaCuidador!.idPersona,
      'persona_cliente_id' : 4, //contrato.personaCliente!.idPersona,
      'contrato_item' : contrato.contratoItem!.map((e) => {
        'observaciones' : e.observaciones,
        'horario_inicio_propuesto' : e.horarioInicioPropuesto?.toIso8601String() ?? '',
        'horario_fin_propuesto' : e.horarioFinPropuesto?.toIso8601String() ?? '',
        'tareas_contrato' : e.tareasContrato!.map((i) => {
          'tituloTarea' : i.tituloTarea,
          'descripcionTarea' : i.descripcionTarea,
          'tipoTarea' : i.tipoTarea,
          'fechaARealizar' : i.fechaRealizar?.toIso8601String() ?? ''
        }).toList()
      }).toList()
    };

    print(jsonRequest);


    try
    {

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonRequest));

      if(response.statusCode == 200)
      {
        return true;
      }
      else
      {
        snackbarUI.snackbarError('Ha Ocurrido Un Error', 'Error al guardar el contrato');
        return false;
      }

    }
    catch(e)
    {

      snackbarUI.snackbarError('Ha Ocurrido Un Error', 'Error al guardar el contrato');
      print(e);
      return false;

    }

  }

}