import 'dart:async';

import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/pickers.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/search_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:one_context/one_context.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ContratoItemList{

  SearchTextfield searchTextfield = SearchTextfield();
  LetterDates letterDates = LetterDates();

  Rx<ContratoItemModel> contratoItemActivo = ContratoItemModel().obs;
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  Pickers pickers = Get.put(Pickers());

  RxBool dateEdit = false.obs;

  void mostrarListadofromModalSheet(List<ContratoItemModel> contrato, String routeimage, int? jumpTo){

    showCupertinoModalBottomSheet(
      bounce: true,
      context: Get.context!, 
      builder: (context) => Material(
        child: SizedBox(
          height: Get.height * 0.8,
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.only(top: 15, right: 10),
                height: Get.height * 0.06,
                width: Get.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.09,
                      height: Get.width * 0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                      child: Image.network(routeimage, fit: BoxFit.cover),
                    ),
                    const Expanded(
                      child: Text(
                        'Resumen Contratos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(icon: const Icon(CupertinoIcons.xmark_circle, size: 20,), color: Colors.black54, onPressed: () {
                      Get.back();
                    },)
                  ],
                ),
              ),

              _separator(),

              listViewContratos(contrato, jumpTo),

              Obx(()=>listViewTareas(contratoItemActivo.value.tareasContrato == null ? contrato.first.tareasContrato! : contratoItemActivo.value.tareasContrato!)),

            ],
          ),
        ),
      )
    );
  }

  Widget listViewTareas(List<TareasContratoModel> tareas){
    return Expanded(
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              tileColor: Colors.blueGrey[900],
              contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              trailing: pullDownButton((index + 1).toString(), tareas[index]),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tareas[index].tituloTarea.toString(), 
                        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        letterDates.formatearFecha(tareas[index].fechaRealizar!).toString(), 
                        style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  PullDownButton pullDownButton(String indexContrato, TareasContratoModel tareasAsignadas){
    return PullDownButton(
      position: PullDownMenuPosition.automatic,
      itemBuilder: (context) =>[
        PullDownMenuHeader(
          leading: Container(
            color: Colors.blueGrey, 
            child: const Icon(CupertinoIcons.clock_fill, color: Colors.white,)), 
          title: 'Tarea Número $indexContrato',
          subtitle: tareasAsignadas.tipoTarea,
          onTap: (){},
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuActionsRow.medium(
          items: [
            // PullDownMenuItem(onTap: (){}, title: 'Ver Detalle', icon: CupertinoIcons.eye),
            PullDownMenuItem(onTap: (){}, title: 'Editar',icon: CupertinoIcons.pencil_circle),
            PullDownMenuItem(onTap: (){}, title: 'Eliminar', icon: CupertinoIcons.delete),
          ]
        )
      ], 
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis, color: Colors.white, size: 15,)
      ) 
    );
  }

  PullDownButton pullDownButtonContrato(ContratoItemModel contrato, int index){
    ContratoController con = Get.find<ContratoController>();

    DateTime fechaContrato = DateTime.parse(contrato.horarioInicioPropuesto!);
    con.selectedTimeStart = contrato.horarioInicioPropuesto!.split(" ")[1].substring(0, 5);
    con.selectedTimeEnd = contrato.horarioFinPropuesto!.split(" ")[1].substring(0, 5);

    con.horariosInicialesDisponibles =  con.extraFunctions.onlyForStartTime(
      con.fechasConCita.where((element) => 
        element.horarioInicioPropuesto != contrato.horarioInicioPropuesto 
        && element.horarioFinPropuesto != contrato.horarioFinPropuesto).toList(), 
      fechaContrato.toString().split(" ")[0]
    );

    con.horasInicialesForEndTimes = con.extraFunctions.generateAvailableTimes(
      con.fechasConCita.where((element) => 
        element.horarioInicioPropuesto != contrato.horarioInicioPropuesto 
        && element.horarioFinPropuesto != contrato.horarioFinPropuesto).toList(), 
      fechaContrato.toString().split(" ")[0]
    );

    return PullDownButton(
      position: PullDownMenuPosition.automatic,
      itemBuilder: (context) =>[
        PullDownMenuHeader(
          leading: Container(
            color: Colors.blueGrey, 
            child: const Icon(CupertinoIcons.clock_fill, color: Colors.white,)), 
          title: 'Contrato ${index + 1}',
          subtitle: '${contrato.tareasContrato!.length.toString()} Tareas',
          onTap: (){},
        ),
        const PullDownMenuDivider.large(),
        const PullDownMenuTitle(title: Text('Acciones')),
        PullDownMenuActionsRow.medium(
          items: [
            PullDownMenuItem(onTap: (){_selectNewDate(contrato, index);}, title: 'Fecha', icon: CupertinoIcons.calendar),
            PullDownMenuItem(onTap: (){
              dateEdit.value = !dateEdit.value;
            }, title: 'Hora',icon: CupertinoIcons.time),
            PullDownMenuItem(onTap: (){}, title: 'Observación', icon: CupertinoIcons.doc_plaintext),
          ]
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuItem(onTap: (){}, title: 'Eliminar', icon: CupertinoIcons.delete, iconColor: Colors.red, isDestructive: true,),
      ], 
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis, color: Colors.black, size: 15,)
      ) 
    );
  }

  Widget listViewContratos(List<ContratoItemModel> contrato, int? jumpTo){
    pageController = PageController(initialPage: jumpTo ?? 0);
    return Obx(()=>
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: dateEdit.value == false ? Get.height * 0.32 : Get.height * 0.45,
        width: Get.width * 0.95,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: PageView.builder(
          onPageChanged: (value) => contratoItemActivo.value = contrato[value],
          scrollDirection: Axis.horizontal,
          itemCount: contrato.length,
          controller: pageController,
          itemBuilder: (context, index){
          return containerContratoItem(contrato[index], index);
        }),
      ),
    );
  }

  Widget containerContratoItem(ContratoItemModel contrato, int indice) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 3000),
    height: Get.height * (dateEdit.value == false ? 0.32 : 0.45),
    width: Get.width * 0.9,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 20,
          offset: Offset(0, 10),
          spreadRadius: 0,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Contrato ${indice + 1}', 
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Text(
              letterDates.formatearSoloFecha(contrato.horarioInicioPropuesto.toString()), 
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 10),

        _separator(),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleFormat('Hora de Inicio'),
                  _titleFormat('Hora de Termino'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _subtitleFormat(letterDates.formatearSoloHora(contrato.horarioInicioPropuesto!)),
                  _subtitleFormat(letterDates.formatearSoloHora(contrato.horarioFinPropuesto!)),
                ],
              ),
            ],
          ),
        ),
        // const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleFormat('Tareas Asignadas'),
                _subtitleFormat('${contrato.tareasContrato!.length.toString()} Tareas')
              ],
            ),
          ],
        ),
        // const SizedBox(height: 10),

        _separator(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _subtitleFormat('Costo Total:'),
            _titleFormat(contrato.importeCuidado.toString()),
            pullDownButtonContrato(contrato, indice)
          ],
        ),

        _separator(),

        dateEdit.value == false ? const SizedBox() : _timeEdit(contrato, indice)

      ],
    ),
  );
}

  Future<void> _selectNewDate(ContratoItemModel contrato, int indexContrato) async{
    DateTime? newDate;
    ContratoController con = Get.find<ContratoController>();

    String sanitizeDateTime(DateTime dateTime) {
      String year = dateTime.year.toString();
      String month = dateTime.month.toString().padLeft(2, '0');
      String day = dateTime.day.toString().padLeft(2, '0');
      return "$year-$month-$day";
    }

    final DateTime? pickDate = await showDatePicker(
      confirmText: 'Seleccionar',
      cancelText: 'Cancelar',
      context: Get.context!,
      initialDate: DateTime.parse(contrato.horarioInicioPropuesto!),
      firstDate: DateTime.parse(contrato.horarioInicioPropuesto!),
      lastDate: DateTime(2025),
      selectableDayPredicate: (day) {
        if (con.fechasNoDisponiblesSet.toString().obs.isNotEmpty) {
          String sanitizedDate = sanitizeDateTime(day);
          bool isDisabled = con.fechasNoDisponiblesSet.toString().obs.value.contains(sanitizedDate);
          return !isDisabled;
        }
        return true;
      },
      initialDatePickerMode: DatePickerMode.day,
      currentDate: DateTime.parse(contrato.horarioInicioPropuesto!),
      builder: (context, child){
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[900]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      }
    );
    DateTime horarioFormat = DateTime.parse(contrato.horarioInicioPropuesto!);
    if(pickDate != null && (pickDate.year != horarioFormat.year || pickDate.month != horarioFormat.month || pickDate.day != horarioFormat.day)){
      newDate = pickDate;
      con.modfifyContratoItem(contrato, newDate, indexContrato, true);
    }

  }

  Widget _timeEdit(ContratoItemModel contrato, int index){
    ContratoController con = Get.find<ContratoController>();
    PageController pageController = PageController();
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.width * 0.9,
      child: GetBuilder<ContratoController>(
        builder: (controller) {
        final value = controller.extraFunctions.formatTime(DateTime.parse(contrato.horarioInicioPropuesto!));
        final items = controller.horariosInicialesDisponibles;
          return PageView(
            controller: pageController,
             children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      dateEdit.value = false;
                    }, icon: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.grey, size: 20,)),
                    pickers.timePicker(
                      'Hora Inicio', 
                      DropdownButtonFormField2<String>(
                        isExpanded: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        value: items.contains(value) ? value : null,
                        items: con.horariosInicialesDisponibles.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                            style: const TextStyle(fontSize: 14),
                          ),
                        )).toList(),
                        validator: (value) => value == null ? 'Campo requerido' : null,
                        onChanged: (value) {
                          con.selectedTimeStart = value!;
                          List<String> horariosFinales = con.extraFunctions.selectedTimeEnd(con.horasInicialesForEndTimes, con.selectedTimeStart);
                          con.horariosFinalesDisponibles.value = horariosFinales;
                        },
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: Get.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    ),
                    IconButton(onPressed: ()=> pageController.jumpToPage(1), icon: const Icon(CupertinoIcons.arrow_right_circle_fill, color: Colors.blueGrey, size: 20,))
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: ()=> pageController.jumpToPage(0), icon: const Icon(CupertinoIcons.arrow_left_circle_fill, color: Colors.blueGrey, size: 20,)),
                    pickers.timePicker(
                      'Hora Fin', 
                      DropdownButtonFormField2<String>(
                        isExpanded: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        value: items.contains(value) ? value : null,
                        items: con.horariosInicialesDisponibles.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                            style: const TextStyle(fontSize: 14),
                          ),
                        )).toList(),
                        validator: (value) => value == null ? 'Campo requerido' : null,
                        onChanged: (value) {
                          con.selectedTimeStart = value!;
                          List<String> horariosFinales = con.extraFunctions.selectedTimeEnd(con.horasInicialesForEndTimes, con.selectedTimeStart);
                          con.horariosFinalesDisponibles.value = horariosFinales;
                        },
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: Get.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green, size: 20,))
                  ],
                )

             ],
          );
        }
      ),
    );
  }

  void cbxTimes (ContratoItemModel contrato, int indice)async {
    ContratoController con = Get.find<ContratoController>();
    return Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        content: Container(
          height: Get.height * 0.2,
          width: Get.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
            ],
          ),
        ),
      )
    );
  }

  Widget _separator(){
    return Container(
      color: Colors.grey,
      height: 0.5,
      width: Get.width * 0.95,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget _titleFormat(String tilte){
    return Text(
      tilte,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }

  Widget _subtitleFormat(String subtitle){
    return Text(
      subtitle,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
    );
  }

}