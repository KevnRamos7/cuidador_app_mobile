import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';

class Dasboard{

  List<FechasConContratos>? fechasConContratos;
  List<HorasPorMes>? horasPorMes;
  ContratoItemModel? contratoEnCurso;

  Dasboard({this.fechasConContratos, this.horasPorMes, this.contratoEnCurso});

  Dasboard.fromJson(Map<String, dynamic> json){
    fechasConContratos = json['fechasConContratos'] != null ? (json['fechasConContratos'] as List).map((i) => FechasConContratos.fromJson(i)).toList() : null;
    horasPorMes = json['horasPorMes'] != null ? (json['horasPorMes'] as List).map((i) => HorasPorMes.fromJson(i)).toList() : null;
    contratoEnCurso = json['contratoEnCurso'] != null ? ContratoItemModel.fromJson(json['contratoEnCurso']) : null;
  }

}

class FechasConContratos{
  DateTime? horarioInicioPropuesto;
  DateTime? horarioFinPropuesto;
  String? nombreCliente;

  FechasConContratos({this.horarioInicioPropuesto, this.horarioFinPropuesto, this.nombreCliente});

  FechasConContratos.fromJson(Map<String, dynamic> json){
    horarioInicioPropuesto = json['horarioInicioPropuesto'];
    horarioFinPropuesto = json['horarioFinPropuesto'];
    nombreCliente = json['nombreCliente'];
  }

}

class HorasPorMes{
  String? mes;
  int? horas;

  HorasPorMes({this.mes, this.horas});

  HorasPorMes.fromJson(Map<String, dynamic> json){
    mes = json['mes'];
    horas = json['horas'];
  }

}