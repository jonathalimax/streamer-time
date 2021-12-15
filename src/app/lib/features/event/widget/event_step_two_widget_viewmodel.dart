import 'dart:io';

import 'package:app/app/app.locator.dart';
import 'package:app/core/constants/theme_constants.dart';
import 'package:app/network/api/firebase_storage_api.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class EventStepTwoWidgetViewModel extends BaseViewModel {
  final _picker = ImagePicker();
  final _firestoreApi = locator<FirestoreApi>();
  final _firebaseStorageApi = locator<FirebaseStorageApi>();
  final _navigationService = locator<NavigationService>();

  final Event? _event;
  final String _title;
  final TwitchGame _category;

  File? _selectedImage;
  DateTime _selectedDateTime;

  EventStepTwoWidgetViewModel(
    this._event,
    this._title,
    this._category,
  ) : _selectedDateTime = _event?.starTime ?? DateTime.now();

  Event? get event => _event;
  String get title => _event?.title ?? _title;
  TwitchGame get category => _category;
  File? get selectedImage => _selectedImage;
  DateTime get selectedDate => _selectedDateTime;

  String get selectedDateFormated {
    return DateFormat('dd MMM').format(_selectedDateTime);
  }

  String get selectedTimeFormated {
    return DateFormat('jm').format(_selectedDateTime);
  }

  Future<void> setDateTime(BuildContext context) async {
    await DatePicker.showDatePicker(
      context,
      theme: ThemeConstants.datePickerTheme,
      showTitleActions: true,
      minTime: DateTime.now(),
      onChanged: (date) {
        this._selectedDateTime = date;
        notifyListeners();
      },
      onConfirm: (date) {
        this._selectedDateTime = date;
        notifyListeners();
      },
      currentTime: _selectedDateTime,
      locale: LocaleType.pt, // TODO: Get user locale
    );
  }

  void showImageSourceActionSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                _selectImage(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Galeria'),
              onPressed: () {
                Navigator.pop(context);
                _selectImage(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              _selectImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Galeria'),
            onTap: () {
              Navigator.pop(context);
              _selectImage(ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image == null) return;
      _selectedImage = File(image.path);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
}
