import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/event/event_data/create_event_data_viewmodel.dart';
import 'package:design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateEventDateViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  DateTime _selectedDateTime = DateTime.now();

  String get selectedDateFormated {
    return DateFormat('dd MMM').format(_selectedDateTime);
  }

  String get selectedTimeFormated {
    return DateFormat('jm').format(_selectedDateTime);
  }

  Future<void> selectDate(BuildContext context) async {
    final today = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
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
    final time = TimeOfDay(
      hour: _selectedDateTime.hour,
      minute: _selectedDateTime.minute,
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
      _selectedDateTime.year,
      _selectedDateTime.month,
      _selectedDateTime.day,
      selected.hour,
      selected.minute,
    );
    notifyListeners();
  }

  Future<void> startEventTimeScreen() async {
    final viewModel = CreateEventDataViewModel(
      _selectedDateTime,
      selectedDateFormated,
      selectedTimeFormated,
    );
    return await _navigation.navigateTo(
      Routes.createEventDataScreen,
      arguments: CreateEventDataScreenArguments(viewModel: viewModel),
    );
  }
}
