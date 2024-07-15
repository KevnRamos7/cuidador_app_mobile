
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class CalendarContainer{

  Widget calendarContainer({
    required double height,
    required double width,
    required Function(DateTime date) onDateChanged,
    List<String>? disabledDates,
  }){

    String sanitizeDateTime(DateTime dateTime) => "${dateTime.year}-${dateTime.month}-${dateTime.day}";

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
          selectableDayPredicate: (DateTime val) {
          String sanitized = sanitizeDateTime(val);
          // disabledDates = sanitizeDateTime()
          return disabledDates!.contains(sanitized);
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
        value: [DateTime.now()],
        onValueChanged: (value) {
          onDateChanged(value[0]);
        },
      )
    );
  }

}