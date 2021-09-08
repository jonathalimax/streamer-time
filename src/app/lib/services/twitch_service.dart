import 'package:app/app/app.locator.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:twitch_api/twitch_api.dart';

const clientId = 'h27c6nhi8gmiuhku6hjv8f2el8z7vj';
const redirectUri = 'https://localhost';

class TwitchService {
  final _authentication = locator<AppAuthentication>();
  final _client = TwitchClient(
    clientId: clientId,
    redirectUri: redirectUri,
  );
  bool _prepared = false;

  TwitchClient get client => _client;

  Future prepare() async {
    if (_prepared) return;

    final token = await _authentication.getTwitchToken();
    if (token == null) return;

    _client.initializeToken(token);
    _prepared = true;
  }
}
