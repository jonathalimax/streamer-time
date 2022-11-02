import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/analytics/analytics.dart';
import 'package:app/core/authentication/authentication_model.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:app/features/discover/discover_viewmodel.dart';
import 'package:app/features/lives/lives_viewmodel.dart';
import 'package:app/features/profile/profile_viewmodel.dart';
import 'package:app/network/api/dio_client.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/widgets/card_game/list/card_game_list_viewmodel.dart';
import 'package:app/widgets/card_streams/card_stream_list_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppAuthentication {
  final _navigation = locator<NavigationService>();
  final _cachingManager = locator<CachingManager>();
  final _analytics = locator<Analytics>();
  final _firebaseAuth = FirebaseAuth.instance;
  final _cookieManager = CookieManager();
  final _dioClient = locator<DioClient>();

  Future<void> persistToken(TwitchToken token) async {
    final authToken = AuthenticationModel.fromToken(token);
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.put(AUTH_TOKEN_KEY, authToken);
    await encryptedBox.close();

    await _firebaseAuth.signInAnonymously();
  }

  Future<bool> isAuthenticated() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final authToken = encryptedBox.get(AUTH_TOKEN_KEY) as AuthenticationModel?;
    await encryptedBox.close();

    if (authToken == null) return false;
    return authToken.expiresIn != 0;
  }

  Future logout() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();
    if (encryptionKey == null) return;

    final userId = await getUserId();
    if (userId != null) _dioClient.unsubscribeFromTopics(userId);

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.delete(AUTH_TOKEN_KEY);
    await encryptedBox.close();
    await _firebaseAuth.signOut();

    _cookieManager.clearCookies();
    _analytics.instance.logEvent(name: 'logout');

    locator.resetLazySingleton<FirestoreApi>();
    locator.resetLazySingleton<LivesViewModel>();
    locator.resetLazySingleton<DiscoverViewmodel>();
    locator.resetLazySingleton<ProfileViewModel>();
    locator.resetLazySingleton<CardStreamListViewModel>();
    locator.resetLazySingleton<CardGameListViewModel>();
    locator.resetLazySingleton<CachingManager>();
    locator.resetLazySingleton<Analytics>();
    locator.resetLazySingleton<DioClient>();

    await _navigation.clearStackAndShow(Routes.startupScreen);
  }

  Future<TwitchToken?> getTwitchToken() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return null;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final authToken =
        await encryptedBox.get(AUTH_TOKEN_KEY) as AuthenticationModel?;
    await encryptedBox.close();

    if (authToken == null) return null;

    return authToken.twitchToken;
  }

  Future<String?> getUserId() async {
    final token = await getTwitchToken();
    return token?.userId;
  }
}
