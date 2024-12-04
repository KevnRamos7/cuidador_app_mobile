import 'dart:convert';

import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContratoRequest extends GetConnect {
  SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> saveContratoInDB(ContratoModel contrato) async {
    String url =
        '${ConnectionString.connectionString}ContratoItem/guardarContrato';
    Map<String, dynamic> jsonRequest = {
      'personaCuidadorId':  contrato.personaCuidador!.idPersona,
      'personaClienteId': contrato.personaCliente!.idPersona,
      'contratoItem': contrato.contratoItem!
          .map((e) => {
                'observacion': e.observaciones,
                'horarioInicioPropuesto':
                    e.horarioInicioPropuesto?.toIso8601String() ?? '',
                'horarioFinPropuesto':
                    e.horarioFinPropuesto?.toIso8601String() ?? '',
                'tareaContrato': e.tareasContrato!
                    .map((i) => {
                          'tituloTarea': i.tituloTarea,
                          'descripcionTarea': i.descripcionTarea,
                          'tipoTarea': i.tipoTarea,
                          // 'estatusId': 18,
                          'fechaARealizar':
                              i.fechaRealizar?.toIso8601String() ?? ''
                        })
                    .toList()
              })
          .toList()
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(jsonRequest));
      print(jsonEncode(jsonRequest));
      switch (response.statusCode) {
        case 200:
          return true;
        case 400:
          snackbarUI.snackbarError("formato peticion incorrecto", "");
          return false;
        case 404:
          snackbarUI.snackbarError("No se encontro", "");
          return false;
        default:
          snackbarUI.snackbarError("Se produjo un error desconocido", "");
          return false;
      }
    } catch (e) {
      snackbarUI.snackbarError('Ha Ocurrido Un Error', 'Error al guardar el contrato');
      return false;
    }
  }
}
