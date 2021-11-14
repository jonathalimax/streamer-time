import 'dart:io';

import 'package:app/app/app.locator.dart';
import 'package:app/network/api/firebase_storage_api.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/event.dart';
import 'package:design_system/styles/app_text_styles.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventDateViewModel extends BaseViewModel {
  final _picker = ImagePicker();
  final _navigationService = locator<NavigationService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _firebaseStorageApi = locator<FirebaseStorageApi>();

  final String _selectedTitle;
  final TwitchGame _selectedCategory;

  File? selectedImage;
  DateTime _selectedDateTime = DateTime.now();

  String get title => _selectedTitle;
  TwitchGame get category => _selectedCategory;

  String get selectedDateFormated {
    return DateFormat('dd MMM').format(_selectedDateTime);
  }

  String get selectedTimeFormated {
    return DateFormat('jm').format(_selectedDateTime);
  }

  CreateEventDateViewModel(
    this._selectedTitle,
    this._selectedCategory,
  );

  Future<void> setDateTime(BuildContext context) async {
    await DatePicker.showDatePicker(
      context,
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        containerHeight: 250,
        itemStyle: ktsBodyBoldStyle,
        cancelStyle: ktsBodyBoldStyle,
        doneStyle: ktsBodyBoldStyle,
      ),
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
      selectedImage = File(image.path);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<String> _buildImageName() async {
    final user = await _firestoreApi.getUser();
    final userName = user?.name ?? '';
    final title = _selectedTitle.toLowerCase().replaceAll(' ', '_');
    return '${userName}_${title}';
  }

  Future<String?> _uploadSelectedImage() async {
    if (selectedImage == null) return null;
    final imageName = await _buildImageName();
    final result = await _firebaseStorageApi.uploadImage(
      selectedImage!,
      name: imageName,
    );
    return result;
  }

  Future<void> createEvent(BuildContext context) async {
    setBusy(true);
    final imageUrl = await _uploadSelectedImage();
    final event = Event(
      title: _selectedTitle,
      starTime: _selectedDateTime,
      categoryId: _selectedCategory.id,
      categoryName: _selectedCategory.name,
      imageUrl: imageUrl,
    );
    await _firestoreApi.createEvent(event);
    _navigationService.popRepeated(2);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText.captionBold('O evento foi criado!'),
      ),
    );
  }
}
