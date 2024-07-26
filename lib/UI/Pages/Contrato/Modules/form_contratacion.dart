import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/contrato_item_list.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/calendar_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/pickers.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormContratacion{

  CalendarContainer calendarContainer = Get.put(CalendarContainer());
  ContratoItemList contratoItemList = Get.put(ContratoItemList());
  FormTextfield formTextfield = Get.put(FormTextfield());
  ContratoController con = Get.put(ContratoController());
  Pickers pickers = Get.put(Pickers());
  // OnchangeFunctions onchangeFunctions = Get.put(OnchangeFunctions());

  Widget listForm(){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: 
            Obx(()=>
              Column(
                  children: [
                
                    _textTitulo('¿Qué dias prefieres?', 0),
                
                    Container(
                      margin: EdgeInsets.only(top: Get.height * 0.04),
                      child: Obx(()=>
                        calendarContainer.calendarContainer(
                          disabledDates: con.fechasNoDisponiblesSet.toString().obs,
                          height: Get.height * 0.4, 
                          width: Get.height * 0.4,
                          onDateChanged: (DateTime date) async{
                            con.onDateChanged(date);
                            con.horariosInicialesDisponibles = con.extraFunctions.generateAvailableTimes(con.fechasConCita, con.selectedDate.value);
                            con.update();
                          }
                        ),
                      )
                    ),
                
                    _textTitulo('¿Qué horarios prefieres?', Get.height * 0.04),

                    _txtSubtitulo('Selecciona una hora de inicio', 10),
                    _listaHoras(1),

                    _txtSubtitulo('Selecciona una hora de finalización', 10),
                    _listaHoras(2),
                
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
                                    onChanged: (value) {
                                      con.cbxTaskOnChange(value!);
                                    }
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
                                        
                          con.cbxAsignTask.value == true ? _listaHoras(3) : const SizedBox(),
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
              
                    con.contratoItems.isNotEmpty ? 
                    SizedBox(
                      width: Get.width * 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white, width: 1)
                          )
                        ),
                        onPressed: () => con.contratoItemList.mostrarListadofromModalSheet(con.contratoItems, con.personaCuidador.persona!.first.avatarImage!, 0), 
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

  Widget _comboTiempoTarea(){
    return GetBuilder<ContratoController>(
      builder: (controller) {
        RxString selectedTimeTask = ''.obs;
        RxList<String> horariosForTask = controller.horariosForTask;
        return Obx(()=>
          Row(
            children: [
              DropdownButton2<String>(
                hint: const Text('Selecciona una hora'),
                value: selectedTimeTask.value,
                items: horariosForTask
                    .map((hora) => DropdownMenuItem<String>(
                          value: hora,
                          child: Text(hora),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedTimeTask.value = value!.padLeft(5, '0');
                  controller.selectedTimeTask = selectedTimeTask;
                },
                alignment: Alignment.center,
                underline: Container(),
                buttonStyleData: ButtonStyleData(
                  height: Get.height * 0.05,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              _botonAgregar('', (){controller.addTareasContrato();
              }, const Color(0xFF395886), CupertinoIcons.add),
            ],
          ),
        );
      }
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
        SizedBox(
          // margin: const EdgeInsets.only(top: 15),
          width: titulo == '' ? Get.width * 0.2 : Get.width * (titulo.length * 0.04),
          height: Get.height * 0.05,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? const Color(0xFF395886),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
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

  Widget _listaHoras(int typeTime) {
  return SizedBox(
    height: Get.height * 0.07,
    width: Get.width * 0.85,
    child: GetBuilder<ContratoController>(
      builder: (controller) {
        return ListView.builder(
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

}