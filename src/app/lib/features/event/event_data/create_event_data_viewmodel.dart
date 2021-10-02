import 'dart:io';

import 'package:app/app/app.locator.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventDataViewModel extends BaseViewModel {
  final _picker = ImagePicker();
  final _twitchService = locator<TwitchService>();

  String? selectedTitle;
  TwitchGame? selectedCategory;
  File? selectedImage;

  final String selectedDateFormated;
  final String selectedTimeFormated;

  CreateEventDataViewModel(
    this.selectedDateFormated,
    this.selectedTimeFormated,
  );

  Future<List<TwitchGame>> getCategorySuggestion(String query) async {
    TwitchResponse<TwitchGame> response;

    response = query.isEmpty
        ? await _twitchService.client.getTopGames()
        : await _twitchService.client.searchCategories(query: query);

    if (response.data == null) [];
    return response.data!
        .where(
          (game) => game.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<void> setCategory(TwitchGame category) async {
    this.selectedCategory = category;
    notifyListeners();
  }

  setTitle(String title) {
    this.selectedTitle = title;
    notifyListeners();
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
}
