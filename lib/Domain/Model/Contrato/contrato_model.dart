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
    idContrato = json['idContrato'];
    personaCuidador = (json['personaCuidador'] != null && json['personaCuidador'].isNotEmpty)
    ? PersonaModel.fromJson(json['personaCuidador'][0])
    : null;
    personaCliente = json['personaCliente'] != null ? PersonaModel.fromJson(json['personaCliente']) : null;
    estatus = json['estatus'] != null ? EstatusModel.fromJson(json['estatus']) : null;
    contratoItem = json['contratoItem'] != null ? (json['contratoItem'] as List).map((v) => ContratoItemModel.fromJson(v)).toList().obs : null;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idContrato'] = idContrato;
    data['personaCuidador'] = personaCuidador;
    data['personaCliente'] = personaCliente;
    data['estatus'] = estatus;
    if(contratoItem != null){
      data['contratoItem'] = contratoItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  

}