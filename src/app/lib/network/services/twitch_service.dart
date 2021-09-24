import 'package:twitch_api/twitch_api.dart';

const clientId = 'h27c6nhi8gmiuhku6hjv8f2el8z7vj';
const redirectUri = 'https://localhost';

class TwitchService {
  final _client = TwitchClient(
    clientId: clientId,
    redirectUri: redirectUri,
  );

  TwitchClient get client => _client;
}
