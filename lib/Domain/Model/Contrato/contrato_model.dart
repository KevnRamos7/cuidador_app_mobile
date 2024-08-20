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
    personaCuidador = (json['persona_cuidador'] != null && json['persona_cuidador'].isNotEmpty)
    ? PersonaModel.fromJson(json['persona_cuidador'][0])
    : null;
    personaCliente = json['persona_cliente'] != null ? PersonaModel.fromJson(json['persona_cliente']) : null;
    estatus = json['estatus'] != null ? EstatusModel.fromJson(json['estatus']) : null;
    contratoItem = json['contrato_item'] != null ? (json['contrato_item'] as List).map((v) => ContratoItemModel.fromJson(v)).toList().obs : null;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_contrato'] = idContrato;
    data['persona_cuidador_id'] = personaCuidador;
    data['persona_cliente_id'] = personaCliente;
    data['estatus'] = estatus;
    if(contratoItem != null){
      data['contrato_item'] = contratoItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  

}