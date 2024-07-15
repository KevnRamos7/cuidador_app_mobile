import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';

class ContratoModel{

  int? idContrato;
  PersonaModel? personaCuidador;
  PersonaModel? personaCliente;
  EstatusModel? estatus;
  RxList<ContratoItemModel>? contratoItem;

  ContratoModel({this.idContrato, this.personaCuidador, this.personaCliente, this.estatus, this.contratoItem});

  ContratoModel.fromJson(Map<String, dynamic> json){
    idContrato = json['id_contrato'];
    personaCuidador = json['persona_cuidador'];
    personaCliente = json['persona_cliente'];
    estatus = json['estatus'];
    if(json['contrato_item'] != null){
      contratoItem!.value = [];
      json['contrato_item'].forEach((v) {
        contratoItem!.value.add(ContratoItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_contrato'] = idContrato;
    data['persona_cuidador'] = personaCuidador;
    data['persona_cliente'] = personaCliente;
    data['estatus'] = estatus;
    if(contratoItem != null){
      data['contrato_item'] = contratoItem!.value.map((v) => v.toJson()).toList();
    }
    return data;
  }
  

}