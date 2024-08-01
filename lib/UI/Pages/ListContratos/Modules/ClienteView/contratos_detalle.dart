import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ListContratos/Models/list_contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/summary_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ContratosDetalle{

  ListContratoController con = Get.put(ListContratoController());
  LetterDates letter = LetterDates();
  SummaryContract summary = SummaryContract();

  Widget contenidoDetalle(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            summary.cuidadorCard(
              nombrePersona: con.contrato.value.personaCuidador!.nombre ?? '', 
              subtitulo: 'Certificaciones', 
              masdatos: [
                con.contrato.value.personaCuidador?.certificaciones?.isNotEmpty == true
                  ? con.contrato.value.personaCuidador!.certificaciones![0].tipoCerficacion ?? ''
                  : '',
                con.contrato.value.personaCuidador?.certificaciones?.isNotEmpty == true
                  ? con.contrato.value.personaCuidador!.certificaciones![1].tipoCerficacion ?? ''
                  : 'Sin certificaciones'
              ],
              costoTotal: con.contrato.value.contratoItem?.isNotEmpty == true
                          ? ' \$ ${con.contrato.value.contratoItem!.map((e) => e.importeCuidado).reduce((value, element) => value! + element!).toString()}'
                          : '0', 
              contratosLigados: con.contrato.value.contratoItem?.isNotEmpty == true
                          ? con.contrato.value.contratoItem!.length.toString()
                          : '0', 
              imagenPerfil: con.contrato.value.personaCuidador?.avatarImage ?? ''
            ),
              
            summary.encabezado('Fechas y Horarios'),
        
            summary.tableForSchedules(con.contrato.value),

            summary.encabezado('Observaciones'),

            summary.observacionesCard(con.contrato.value),
        
            summary.encabezado('Lista de Tareas'),
        
            summary.tableForTask(con.contrato.value),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}