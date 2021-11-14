import 'package:hive/hive.dart';
import 'package:twitch_api/twitch_api.dart';

part 'authentication_model.g.dart';

@HiveType(typeId: 1)
class AuthenticationModel {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final String scope;

  @HiveField(2)
  final String tokenType;

  @HiveField(3)
  final int expiresIn;

  @HiveField(4)
  final String? clientId;

  @HiveField(5)
  final String? login;

  @HiveField(6)
  final List<String>? scopes;

  @HiveField(7)
  final String? userId;

  AuthenticationModel({
    required this.token,
    required this.scope,
    required this.tokenType,
    required this.expiresIn,
    this.clientId,
    this.login,
    this.scopes,
    this.userId,
  });

  AuthenticationModel.fromToken(TwitchToken token)
      : this.token = token.token,
        this.scope = token.scope,
        this.tokenType = token.tokenType,
        this.expiresIn = token.expiresIn,
        this.clientId = token.clientId,
        this.login = token.login,
        this.scopes = token.scopes,
        this.userId = token.userId;

  TwitchToken get twitchToken => TwitchToken(
        token: this.token,
        scope: this.scope,
        tokenType: this.tokenType,
        clientId: this.clientId,
        expiresIn: this.expiresIn,
        login: this.login,
        scopes: this.scopes,
        userId: this.userId,
      );
}
