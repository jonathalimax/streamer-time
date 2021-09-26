import 'package:design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateEventTimeViewModel extends BaseViewModel {
  TimeOfDay? _selectedTime;

  String get selectedTimeFormated {
    if (_selectedTime == null) return '';
    final hour = _selectedTime!.hour.toString().padLeft(2, '0');
    final minute = _selectedTime!.minute.toString().padLeft(2, '0');
    return ': $hour:$minute';
  }

  Future<void> selectTime(BuildContext context) async {
    final now = DateTime.now().hour + 1;
    final time = TimeOfDay(hour: now, minute: 0);
    final selected = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? time,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.secondary,
            ),
            dialogBackgroundColor: kcIceWhite,
          ),
          child: child!,
        );
      },
    );

    if (selected == null) return;

    this._selectedTime = selected;
    notifyListeners();
  }
}
