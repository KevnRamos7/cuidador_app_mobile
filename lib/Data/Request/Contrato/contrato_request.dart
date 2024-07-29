import 'dart:convert';

import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class ContratoRequest extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> saveContratoInDB(ContratoModel contrato) async{

    String url = 'http://localhost:3000/contrato';
    Map<String, dynamic> jsonRequest = {
      'persona_cuidador_id' : contrato.personaCuidador!.idPersona,
      'persona_cliente_id' : contrato.personaCliente!.idPersona,
      'contrato_item' : contrato.contratoItem!.map((e) => {
        'observaciones' : e.observaciones,
        'horario_inicio_propuesto' : e.horarioInicioPropuesto,
        'horario_fin_propuesto' : e.horarioFinPropuesto,
        'tareas_contrato' : e.tareasContrato!.map((i) => {
          'titulo_tarea' : i.tituloTarea,
          'descripcion_tarea' : i.descripcionTarea,
          'tipo_tarea' : i.tipoTarea,
          'fecha_a_realizar' : i.fechaRealizar
        }).toList()
      })
    };

    return true;

    // try
    // {

      
    //   return true;

    //   // final response = await post(url, jsonRequest);

    //   // switch(response.statusCode)
    //   // {
    //   //   case 200:
    //   //     return true;
    //   //   case 400:
    //   //     return false;
    //   //   default:
    //   //     snackbarUI.snackbarError('Ha Ocurrido Un Error', 'Error al guardar el contrato');
    //   //     return false;
    //   // }

    // }
    // catch(e)
    // {

    //   snackbarUI.snackbarError('Ha Ocurrido Un Error', 'Error al guardar el contrato');
    //   return false;

    // }

  }

}