import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

typedef Users = List<User>?;

class AgendaViewModel extends FutureViewModel<Users> {
  final _navigation = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();

  @override
  Future<Users> futureToRun() async {
    return await _getFollowedStreamers();
  }

  Future<Users> _getFollowedStreamers() async {
    return await _streamerService.getFollowingStreamers();
  }

  Future<void> startCreateEvent() async {
    return await _navigation.navigateTo(Routes.createEventDateTimeScreen);
  }

  Future<void> openStreamerWebview(String username) async {
    // await _navigation.navigateTo(
    //   Routes.webViewScreen,
    //   arguments: WebViewScreenArguments(
    //     url: 'https://twitch.tv/$username',
    //     shouldNavigate: _handleUrl,
    //   ),
    // );
    var url = 'https://www.twitch.tv/$username';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        universalLinksOnly: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> openStreamerScreen(String streamerId) async {
    final viewModel = StreamerViewModel(streamerId: streamerId);
    await _navigation.navigateTo(
      Routes.streamerScreen,
      arguments: StreamerScreenArguments(viewModel: viewModel),
    );
  }
}
