import 'dart:async';

import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/extra_functions.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/pickers.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/search_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class ContratoItemList{

  SearchTextfield searchTextfield = SearchTextfield();
  LetterDates letterDates = LetterDates();

  Rx<ContratoItemModel> contratoItemActivo = ContratoItemModel().obs;
  int indexContratoActivo = 0;
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  Pickers pickers = Get.put(Pickers());
  PageController pageTimesController = PageController();

  RxBool dateEdit = false.obs;
  RxBool isStartTime = true.obs;

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

              Obx(()=>listViewTareas(
                contratoItemActivo.value.tareasContrato == null ? contrato.first.tareasContrato! : contratoItemActivo.value.tareasContrato!
              )),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton.small(onPressed: (){
                      ContratoController con = Get.find();
                      ExtraFunctions extra = ExtraFunctions();
                      ContratoItemModel contratoItemModel = contratoItemActivo.value.horarioInicioPropuesto == null ? contrato.first : contratoItemActivo.value;
                      String horaInicio = extra.formatTime(contratoItemModel.horarioInicioPropuesto!).padLeft(5, '0');
                      String horaFin = extra.formatTime(contratoItemModel.horarioFinPropuesto!).padLeft(5, '0');

                      DateTime inicial = extra.stringToDateTime(horaInicio);
                      DateTime fin = extra.stringToDateTime(horaFin);

                      con.horariosForTask.value = extra.availableTimesForTask(inicial, fin ,contratoItemModel.tareasContrato!);
                      con.horariosForTask.refresh();
                      con.selectedTimeTask.value = '';
                      _dialogNewTask(indexContratoActivo);
                    }
                    , tooltip: 'Añadir Tarea'
                    , child: const Icon(CupertinoIcons.add, color: Colors.white,),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      )
    );
  }

  

  // ? MAS OPCIONES DE EDICIÓN

  PullDownButton pullDownButton(TareasContratoModel tareasAsignadas, int indiceTarea, int indiceContrato){
    TextEditingController edicion = TextEditingController();
    return PullDownButton(
      position: PullDownMenuPosition.automatic,
      itemBuilder: (context) =>[
        PullDownMenuHeader(
          leading: Container(
            color: Colors.blueGrey, 
            child: const Icon(CupertinoIcons.clock_fill, color: Colors.white,)), 
          title: 'Tarea Número ${indiceTarea + 1}',
          subtitle: tareasAsignadas.tipoTarea,
          onTap: (){},
        ),
        const PullDownMenuDivider.large(),
        const PullDownMenuTitle(title: Text('Acciones')),
        PullDownMenuActionsRow.medium(
          items: [
            PullDownMenuItem(onTap: (){
              _dialogTarea(tareasAsignadas, indiceTarea, 'Titulo', edicion, true);
            }, title: 'Titulo', icon: CupertinoIcons.pencil_circle),
            PullDownMenuItem(onTap: (){
              _dialogTarea(tareasAsignadas, indiceTarea, 'Descripción', edicion, false);
            }, title: 'Descripción',icon: CupertinoIcons.pencil_circle),
            PullDownMenuItem(onTap: (){
              ContratoController con = Get.find<ContratoController>();
              ContratoItemModel contratoModel = con.contratoItems[indiceContrato];
              con.horariosForTask.value = con.extraFunctions.availableTimesForTask(
                contratoModel.horarioInicioPropuesto!,
                contratoModel.horarioFinPropuesto!,
                contratoModel.tareasContrato!
              );
              _dialogTimeTask(tareasAsignadas, indiceTarea);
            }, title: 'Hora', icon: CupertinoIcons.time),
          ]
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuItem(onTap: (){
          ContratoController con = Get.find<ContratoController>();
          con.deleteContratoOrTask(indiceContrato, indiceTarea);
        }, title: 'Eliminar', icon: CupertinoIcons.delete, iconColor: Colors.red, isDestructive: true,),
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
    TextEditingController observaciones = TextEditingController();

    DateTime fechaContrato = contrato.horarioInicioPropuesto!;
    con.selectedTimeStart.value = contrato.horarioInicioPropuesto!.toString().split(" ")[1].substring(0, 5);
    con.selectedTimeEnd.value = contrato.horarioFinPropuesto!.toString().split(" ")[1].substring(0, 5);

    con.horariosInicialesDisponibles =  con.extraFunctions.onlyForStartTime(
      con.fechasConCita.where((element) => 
        element.horarioInicioPropuesto != contrato.horarioInicioPropuesto 
        && element.horarioFinPropuesto != contrato.horarioFinPropuesto).toList(), 
      fechaContrato
    );

    con.horasInicialesForEndTimes = con.extraFunctions.generateAvailableTimes(
      con.fechasConCita.where((element) => 
        element.horarioInicioPropuesto != contrato.horarioInicioPropuesto 
        && element.horarioFinPropuesto != contrato.horarioFinPropuesto).toList(), 
      fechaContrato
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
            PullDownMenuItem(onTap: (){
              observaciones.text = contrato.observaciones ?? '';
              Get.defaultDialog(
                title: 'Observación',
                radius: 10,
                titlePadding: const EdgeInsets.symmetric(vertical: 10),
                content: Column(
                  children: [
                    TextFormField(
                      controller: observaciones,
                      
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintMaxLines: 10,
                        hintText: 'Escribe una observación',
                        labelText: 'Observación',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 3, 39, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () => con.modifyObservaciones(observaciones.text, index),
                        child: const Text('Guardar', style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                )
              );
            }, title: 'Observación', icon: CupertinoIcons.doc_plaintext),
          ]
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuItem(onTap: (){
          ContratoController con = Get.find<ContratoController>();
          con.deleteContratoOrTask(index, -1);
        }, title: 'Eliminar', icon: CupertinoIcons.delete, iconColor: Colors.red, isDestructive: true,),
      ], 
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: const EdgeInsets.all(0),
        child: const Icon(CupertinoIcons.ellipsis, color: Colors.black, size: 15,)
      ) 
    );
  }

  // ? LISTADO DE CONTRATOS Y TAREAS

  Widget listViewTareas(List<TareasContratoModel> tareas){
    return Expanded(
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ExpansionTile(
              backgroundColor: Colors.blueGrey[900],
              collapsedBackgroundColor: Colors.blueGrey[900],
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              trailing: pullDownButton(tareas[index], index, 0),
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
                        letterDates.formatearFecha(tareas[index].fechaRealizar!.toString()).toString(), 
                        style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.only(left: Get.width * 0.1),
                  height: Get.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _separator(),
                      Text(
                        tareas[index].descripcionTarea.toString(), 
                        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
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
          onPageChanged: (value) {contratoItemActivo.value = contrato[value]; indexContratoActivo = value;},
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
  ContratoController con = Get.find();
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
                  _subtitleFormat(letterDates.formatearSoloHora(contrato.horarioInicioPropuesto!.toString())),
                  _subtitleFormat(letterDates.formatearSoloHora(contrato.horarioFinPropuesto!.toString())),
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

        Visibility(visible: dateEdit.value,
        child: Obx(()=>
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _separator(),
              isStartTime.value ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => dateEdit.value = false, icon: const Icon(CupertinoIcons.xmark_circle_fill, size: 25, color: Colors.grey,)),
                  _listaHoras(1),
                  IconButton(
                    onPressed: () {
                      isStartTime.value = false;
                    }, icon: const Icon(CupertinoIcons.arrow_right_circle_fill, size: 25, color: Colors.blueGrey,))
                ],
              ) : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => isStartTime.value = true, icon: const Icon(CupertinoIcons.arrow_left_circle_fill, size: 25, color: Colors.blueGrey,)),
                  _listaHoras(2),
                  IconButton(
                    onPressed: () {
                      con.modfifyContratoItem(contrato, null, indice, false);
                      dateEdit.value = false;
                      isStartTime.value = true;
                    }, icon: const Icon(CupertinoIcons.check_mark_circled_solid, size: 25, color: Colors.green,)),
                ],
              ),
              const SizedBox(height: 15,),
              Obx(()=>
                Text('${con.selectedTimeStart.value} -- ${con.selectedTimeEnd.value}',
                 style: const TextStyle(color: Colors.grey, fontSize: 13),),
              )
            ],
          ),
        )),
      ],
    ),
  );
}

  // ? FUNCIONES DE EDICIÓN DE CONTRATO

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
      initialDate: contrato.horarioInicioPropuesto!,
      firstDate: contrato.horarioInicioPropuesto!,
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
      currentDate: contrato.horarioInicioPropuesto!,
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
    DateTime horarioFormat = contrato.horarioInicioPropuesto!;
    if(pickDate != null && (pickDate.year != horarioFormat.year || pickDate.month != horarioFormat.month || pickDate.day != horarioFormat.day)){
      newDate = pickDate;
      con.modfifyContratoItem(contrato, newDate, indexContrato, true);
    }

  }

  Future<void> _dialogTarea(TareasContratoModel tarea, int indice, String editText, TextEditingController edicion, bool isTitle){
    // TextEditingController edicion = TextEditingController();
    ContratoController con = Get.find<ContratoController>();
    edicion.text = (isTitle ? tarea.tituloTarea : tarea.descripcionTarea) ?? '';
    return Get.defaultDialog(
      title: editText,
      radius: 10,
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        children: [
          TextFormField(
            controller: edicion,
            decoration:  InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              hintMaxLines: 10,
              hintText: 'Escribe $editText',
              labelText: editText,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: Get.width * 0.3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 39, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => con.modifyTareasContrato(edicion.text, indice, indexContratoActivo, isTitle),
              child: const Text('Guardar', style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      )
    );
  }

  Future<void> _dialogTimeTask(TareasContratoModel tarea, int indice){
    ContratoController con = Get.find<ContratoController>();
    return Get.defaultDialog(
      title: 'Hora de la Tarea',
      radius: 10,
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.4,
                height: Get.height * 0.1,
                child: _timePicker('Hora de la Tarea', DropdownButtonFormField2<String>(
                  isExpanded: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // value: con.selectedTimeEnd,
                  items: con.horariosForTask.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                      style: const TextStyle
                      (fontSize: 14),
                    ),
                  )).toList(),
                  validator: (value) => value == null ? 'Campo requerido' : null,
                  onChanged: (value) {
                    con.selectedTimeTask.value = value!;
                  },
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: Get.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ))
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: Get.width * 0.3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 39, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => con.modifyHorarioTarea(con.selectedTimeTask.value, indexContratoActivo, indice),
              child: const Text('Guardar', style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      )
    );
  }

  Future<void> _dialogNewTask(int indiceContrato){
    ContratoController con = Get.find();
    FormTextfield form = Get.put(FormTextfield());
    return Get.defaultDialog(
      title: 'Añadir Tarea',
      radius: 5,
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        children: [
          _separator(),
          _txtTitulo2('Titulo', 10),
          form.form_txt(
            controller: con.txtTituloTarea.value,
            padding: Get.height * 0.02,
            height: Get.height * 0.05,
            width: Get.width * 0.8,
            contentPaddingTop: 0,
            contentPaddingLeft: 20,
            hintText: 'Ejercicio Matutino, Limpieza del Hogar, etc.',
          ),
          _txtTitulo2('Descripción', Get.height * 0.02),
          form.form_txt(
            controller: con.txtDescripcionTarea.value,
            padding: Get.height * 0.02,
            height: Get.height * 0.1,
            width: Get.width * 0.8,
            contentPaddingTop: 10,
            maxLines: 10,
            hintText: 'Mantener el área de convivencia del paciente limpia y ordenada. Esto incluye la limpieza de la habitación, sala, cocina y baño.',
          ),
          _txtTitulo2('Hora de prefererencia', Get.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _listaHoras(3),
              IconButton.filled(onPressed: (){
                con.addTareasFromModal(indiceContrato);
              }, icon: const Icon(CupertinoIcons.add, size: 20,color: Colors.white,))
            ],
          ) 
        ],
      )
    );
  }

  // ** FORMATO DE WIDGETS **

  Widget _timePicker(String titulo, Widget timePickerDropdown) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // key: const Key('pickers'),
              width: Get.width * 0.4,
              height: Get.height * 0.05,
              child: timePickerDropdown
            )
          ],
        ),
        titulo == '' ? const SizedBox() : Text(
          titulo, 
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center),
      ],
    ),
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

  Widget _listaHoras(int typeTime) {
  List<ScrollController> controladores = [
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];
  return SizedBox(
    height: Get.height * 0.07,
    width: typeTime == 3 ? Get.width * 0.55 : Get.width * 0.5,
    child: GetBuilder<ContratoController>(
      builder: (controller) {
        return ListView.builder(
          controller: controladores[typeTime - 1],
          scrollDirection: Axis.horizontal,
          itemCount: typeTime == 1 ? controller.horariosInicialesDisponibles.length 
            : (typeTime == 2  ? controller.horariosFinalesDisponibles.length : 
            controller.horariosForTask.length),
          itemBuilder: (context, index) {
            String hora = typeTime == 1 ? controller.horariosInicialesDisponibles[index] 
            : (typeTime == 2  ? controller.horariosFinalesDisponibles[index] : 
            controller.horariosForTask[index]);
            bool isSelected = (typeTime == 1 ? controller.selectedTimeStart.value :
            (typeTime == 2 ? controller.selectedTimeEnd.value : controller.selectedTimeTask.value)
            ) == hora;
        
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  controller.onTimeSelected(hora, typeTime);
                  if(typeTime == 1){
                    controladores[typeTime - 1].animateTo(
                      controladores[typeTime - 1].position.minScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Card(
                  color: isSelected ? Colors.blueGrey : Colors.white,
                  elevation: 5,
                  child: Container(
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      hora,
                      style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    )
  );
}

  Widget _txtTitulo2(String titulo, double padding){
    return Container(
      width: Get.width * 0.75,
      margin: EdgeInsets.only(top: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            titulo, 
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

}