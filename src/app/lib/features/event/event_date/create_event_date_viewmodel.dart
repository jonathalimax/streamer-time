import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateEventDateViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  DateTime? _selectedDate;

  String get selectedDateFormated {
    if (_selectedDate == null) return '';
    final date = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    return ': $date';
  }

  Future<void> selectDate(BuildContext context) async {
    final today = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? today,
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

    this._selectedDate = selected;
    notifyListeners();
  }

  Future<void> startEventTimeScreen() async {
    return await _navigation.navigateTo(Routes.createEventTimeScreen);
  }
}
