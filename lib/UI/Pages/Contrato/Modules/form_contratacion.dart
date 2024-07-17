import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/calendar_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class FormContratacion{

  CalendarContainer calendarContainer = Get.put(CalendarContainer());
  FormTextfield formTextfield = Get.put(FormTextfield());
  ContratoController con = Get.put(ContratoController());

  Widget listForm(){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Obx(()=>
            Column(
              children: [
            
                _textTitulo('¿Qué dias prefieres?', 0),
            
                Container(
                  margin: EdgeInsets.only(top: Get.height * 0.04),
                  child: calendarContainer.calendarContainer(
                    disabledDates: con.fechasNoDisponiblesSet,
                    height: Get.height * 0.4, 
                    width: Get.height * 0.4,
                    onDateChanged: (DateTime date){con.date = date;}
                  )
                ),
            
                _textTitulo('¿Qué horarios prefieres?', Get.height * 0.04),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _timePicker('Hora Inicio', (DateTime date){con.dateStart = date;}),
                    _timePicker('Hora Fin', (DateTime date){con.dateEnd = date;}),
                  ],
                ),
            
                _textTitulo('¿Alguna Observación?', Get.height * 0.04),
            
                _txtSubtitulo('Recuerda que puedes dejar comentarios / notas a tu cuidador para un cuidador más personalizado.', Get.height * 0.01),
            
                formTextfield.form_txt(
                  controller: con.txtObservacion.value,
                  padding: Get.height * 0.03,
                  height: Get.height * 0.2,
                  width: Get.width * 0.8,
                  hintText: 'Mi padre suele tener dificultades para comer, especialmente durante el desayuno. Sería ideal que se le motive pacientemente para que coma al menos ...',
                ),
            
                Container(
                  margin: EdgeInsets.only(top: Get.height * 0.04),
                  child: Row(
                    children: [
                      _textTitulo('¿Quieres Asignar Tareas?', 0),
                      Obx(()=>
                      Checkbox(
                        value: con.cbxAsignTask.value, 
                        onChanged: (value) {con.cbxAsignTask.value = value!;}
                        , activeColor: const Color(0xFF395886)
                        , checkColor: Colors.white
                        )
                      ),
                    ],
                  ),
                ),
            
                _txtSubtitulo('En “Cuidador”, puedes generar una lista de tareas o actividades que tu cuidador debe realizar durante el cuidado en curso.', 10),
            
                con.cbxAsignTask.value == true ? _txtTitulo2('Titulo', Get.height * 0.02) : const SizedBox(),
            
                con.cbxAsignTask.value == true ? formTextfield.form_txt(
                  controller: con.txtTituloTarea.value,
                  padding: Get.height * 0.02,
                  height: Get.height * 0.05,
                  width: Get.width * 0.8,
                  contentPaddingTop: 0,
                  contentPaddingLeft: 20,
                  hintText: 'Ejercicio Matutino, Limpieza del Hogar, etc.',
                ) : const SizedBox(),
            
                con.cbxAsignTask.value == true ? _txtTitulo2('Descripción', Get.height * 0.02) : const SizedBox(),
            
                con.cbxAsignTask.value == true ? formTextfield.form_txt(
                  controller: con.txtDescripcionTarea.value,
                  padding: Get.height * 0.02,
                  height: Get.height * 0.1,
                  width: Get.width * 0.8,
                  contentPaddingTop: 10,
                  maxLines: 10,
                  hintText: 'Mantener el área de convivencia del paciente limpia y ordenada. Esto incluye la limpieza de la habitación, sala, cocina y baño.',
                ) : const SizedBox(),
            
                con.cbxAsignTask.value == true ? _txtTitulo2('Hora de prefererencia', Get.height * 0.04) : const SizedBox(),  
            
                con.cbxAsignTask.value == true ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _timePicker('', (DateTime date){con.dateTask = date;}),
                    _botonAgregar('', (){con.addTareasContrato();}, const Color(0xFF395886), null),
                    _botonAgregar('Lista', (){}, Colors.black87, CupertinoIcons.square_list),
            
                  ],
                ) : const SizedBox(),

                const SizedBox(height: 20),

                Text('${con.tareasContrato.length} Tareas', style: const TextStyle(fontSize: 15, color: Colors.black54),),

                const SizedBox(height: 20),

                SizedBox(
                  width: Get.width * 0.6,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black45, width: 1)
                      )
                    ),
                    onPressed: () => con.saveContratoItem(), 
                    child: const Text(
                      'Guardar Fecha', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                con.contratoItems.isNotEmpty ? SizedBox(
                  width: Get.width * 0.6,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white, width: 1)
                      )
                    ),
                    onPressed: () => con.contratoItemList.mostrarListadofromModalSheet(con.contratoItems), 
                    child: const Text(
                      'Ver Solicitudes', 
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ) : const SizedBox(),
            
                const SizedBox(height: 100)
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textTitulo(String titulo, double padding){
    return Container(
      margin: EdgeInsets.only(top: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            titulo, 
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  Widget _txtSubtitulo(String titulo, double padding){
    return Container(
      width: Get.width * 0.75,
      margin: EdgeInsets.only(top: padding),
      child: Text(
        titulo, 
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.w100),
        ),
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

  Widget _botonAgregar(String titulo, Function evento, Color? color, IconData? icono){
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          width: titulo == '' ? Get.width * 0.15 : Get.width * (titulo.length * 0.06),
          height: Get.height * 0.05,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? const Color(0xFF395886),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            onPressed: () => evento(),
            child: 
             titulo == '' ? const Icon(CupertinoIcons.add, color: Colors.white, size: 20) :
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 15),),
                Icon(icono ?? CupertinoIcons.add, color: Colors.white, size: 20)
              ],
             )
          ),
        ),
      ],
    );
  }

  Widget _timePicker(String titulo, Function(DateTime date)? dateChange){
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TimePickerSpinnerPopUp(
                onChange: (p0) => dateChange!(p0),
                mode: CupertinoDatePickerMode.values[1],
                // initTime: DateTime.now(),
              ),
            ],
          ),
          titulo == '' ? const SizedBox() :
           Text(titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
        ],
      ),
    );
  }

}