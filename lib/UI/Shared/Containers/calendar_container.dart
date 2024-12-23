import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarContainer {
  Widget calendarContainer({
    required double height,
    required double width,
    required Function(DateTime date) onDateChanged,
    required Rx<String> disabledDates
  }) {
    // Función para convertir DateTime a un formato de cadena compatible
    String sanitizeDateTime(DateTime dateTime) {
      String year = dateTime.year.toString();
      String month = dateTime.month.toString().padLeft(2, '0');
      String day = dateTime.day.toString().padLeft(2, '0');
      return "$year-$month-$day";
    }

    return Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 30,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          selectableDayPredicate: (DateTime dateTime) {
            if (disabledDates.isNotEmpty) {
              String sanitizedDate = sanitizeDateTime(dateTime);
              bool isDisabled = disabledDates.value.contains(sanitizedDate);
              //quitar fechas anteriores a la fecha actual
              if (dateTime.isBefore(DateTime.now()) || dateTime.isAtSameMomentAs(DateTime.now())) {
                return false;
              }
              return !isDisabled;
            }
            return true;
          },
          disabledDayTextStyle: const TextStyle(color: Colors.grey),
          calendarType: CalendarDatePicker2Type.single,
          daySplashColor: Colors.white,
          selectedDayHighlightColor: const Color.fromARGB(255, 9, 87, 151),
          selectedRangeHighlightColor: const Color.fromARGB(255, 176, 230, 255).withOpacity(0.5),
          selectedDayTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: [DateTime.now().add(const Duration(days: 1))],
        onValueChanged: (value) {
          onDateChanged(value[0]);
        },
      ),
    );
  }
}