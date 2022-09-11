import 'dart:io';

import 'package:app/app/app.locator.dart';
import 'package:app/network/api/firebase_storage_api.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/event.dart';
import 'package:app/network/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventStepTwoViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();
  final _eventService = locator<EventService>();
  final _navigationService = locator<NavigationService>();
  final _firebaseStorageApi = locator<FirebaseStorageApi>();

  final String _title;
  final TwitchGame _category;

  String get title => _title;
  TwitchGame get category => _category;

  CreateEventStepTwoViewModel(
    this._title,
    this._category,
  );

  Future<String> _buildImageName() async {
    final user = await _firestoreApi.getUser();
    final userName = user?.name ?? '';
    final title = _title.toLowerCase().replaceAll(' ', '_');
    return '${userName}_${title}';
  }

  Future<String?> _uploadSelectedImage(File? image) async {
    if (image == null) return null;
    final imageName = await _buildImageName();
    final result = await _firebaseStorageApi.uploadImage(
      image,
      name: imageName,
    );
    return result;
  }

  Future<void> createEvent(
    BuildContext context,
    File? image,
    DateTime startDate,
    Duration duration,
  ) async {
    setBusy(true);

    final imageUrl = await _uploadSelectedImage(image);

    final event = Event(
      title: _title,
      starTime: startDate,
      categoryId: _category.id,
      categoryName: _category.name,
      imageUrl: imageUrl,
      duration: duration.inMinutes,
    );

    await _eventService.createEvent(event);
    _navigationService.popRepeated(2);
  }
}
