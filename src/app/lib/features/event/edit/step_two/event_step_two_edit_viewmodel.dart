import 'dart:io';

import 'package:app/app/app.locator.dart';
import 'package:app/network/api/firebase_storage_api.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/event.dart';
import 'package:app/network/services/event_service.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class EventStepTwoEditViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();
  final _eventService = locator<EventService>();
  final _navigationService = locator<NavigationService>();
  final _firebaseStorageApi = locator<FirebaseStorageApi>();

  final Event _event;
  final TwitchGame _category;

  Event get event => _event;
  TwitchGame get category => _category;

  EventStepTwoEditViewModel(
    this._event,
    this._category,
  );

  Future<String> _buildImageName() async {
    final user = await _firestoreApi.getUser();
    final userName = user?.name ?? '';
    final title = _event.title.toLowerCase().replaceAll(' ', '_');
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

  Future<void> saveEvent(
    BuildContext context,
    File? image,
    DateTime startDate,
  ) async {
    setBusy(true);

    final imageUrl = await _uploadSelectedImage(image);

    if (imageUrl != null) _event.imageUrl = imageUrl;
    _event.starTime = startDate;

    await _eventService.editEvent(event);

    await _navigationService.back();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText.captionBold('O evento foi salvo!'),
      ),
    );
  }
}
