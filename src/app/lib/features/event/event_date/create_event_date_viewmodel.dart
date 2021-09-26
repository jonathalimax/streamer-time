import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateEventDateViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  DateTime? _selectedDateTime;

  String get selectedDateFormated {
    final now = _selectedDateTime ?? DateTime.now();
    return DateFormat('dd MMM').format(now);
  }

  String get selectedTimeFormated {
    final date = _selectedDateTime ?? DateTime.now().add(Duration(hours: 1));
    final DateFormat formatter = DateFormat('jm');
    return formatter.format(date);
  }

  Future<void> selectDate(BuildContext context) async {
    final today = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? today,
      firstDate: today,
      lastDate: DateTime(DateTime.now().year + 5),
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

    this._selectedDateTime = selected;
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    final dateTime =
        _selectedDateTime ?? DateTime.now().add(Duration(hours: 1));
    final time = TimeOfDay(
      hour: dateTime.hour,
      minute: dateTime.minute,
    );
    final selected = await showTimePicker(
      context: context,
      initialTime: time,
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

    this._selectedDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      selected.hour,
      selected.minute,
    );
    notifyListeners();
  }

  Future<void> startEventTimeScreen() async {}
}
