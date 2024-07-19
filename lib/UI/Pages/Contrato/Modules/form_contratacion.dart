import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/calendar_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormContratacion{

  CalendarContainer calendarContainer = Get.put(CalendarContainer());
  FormTextfield formTextfield = Get.put(FormTextfield());
  ContratoController con = Get.put(ContratoController());

  Widget listForm(){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: 
            Column(
                children: [
              
                  _textTitulo('¿Qué dias prefieres?', 0),
              
                  Container(
                    margin: EdgeInsets.only(top: Get.height * 0.04),
                    child: calendarContainer.calendarContainer(
                      disabledDates: con.fechasNoDisponiblesSet.toString().obs,
                      height: Get.height * 0.4, 
                      width: Get.height * 0.4,
                      onDateChanged: (DateTime date) async{
                        con.onDateChanged(date);
                        con.horariosInicialesDisponibles = await con.extraFunctions.generateAvailableTimes(con.fechasConCita, con.selectedDate.value.toString().split(" ")[0]);
                        con.update();
                      }
                    )
                  ),
              
                  _textTitulo('¿Qué horarios prefieres?', Get.height * 0.04),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetBuilder<ContratoController>(
                        builder: (controller) {
                          final value = controller.selectedTimeStart;
                          final items = controller.horariosInicialesDisponibles;
                          return _timePicker(
                            'Hora Inicio', 
                            DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                                con.onTimeStartChanged(value!);
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              )
                            );
                        }
                      )
                      ,GetBuilder<ContratoController>(
                        builder: (controller) {
                          final value = controller.selectedTimeEnd;
                          final items = controller.horariosFinalesDisponibles;
                          return _timePicker(
                            'Hora Fin', 
                            DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              value: items.contains(value) ? controller.horariosFinalesDisponibles.first : null,
                              items: con.horariosFinalesDisponibles.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              )).toList(),
                              validator: (value) => value == null ? 'Campo requerido' : null,
                              onChanged: (value) {
                                con.selectedTimeEnd = value!;
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            )
                          );
                        }
                      )
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
              
                  Obx(()=>
                    Column(
                      children: [
                    
                        Container(
                            margin: EdgeInsets.only(top: Get.height * 0.04),
                            child: Row(
                              children: [
                                _textTitulo('¿Quieres Asignar Tareas?', 0),
                                Checkbox(
                                  value: con.cbxAsignTask.value, 
                                  onChanged: (value) {con.cbxAsignTask.value = value!;}
                                  , activeColor: const Color(0xFF395886)
                                  , checkColor: Colors.white
                                  )
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
                            _timePicker(
                              '', 
                              DropdownButtonFormField2<String>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                value: con.horariosInicialesDisponibles.first,
                                items: con.horariosInicialesDisponibles.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )).toList(),
                                validator: (value) => value == null ? 'Campo requerido' : null,
                                onChanged: (value) {
                                  con.selectedTimeStart = value!;
                                },
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                              )
                            ),
                            _botonAgregar('', (){con.addTareasContrato();}, const Color(0xFF395886), null),
                            _botonAgregar('Lista', (){}, Colors.black87, CupertinoIcons.square_list),
                                      
                          ],
                        ) : const SizedBox(),
                      ],
                    ),
                  ),
            
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
              width: Get.width * 0.3,
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


}