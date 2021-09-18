import 'package:app/features/channels/channels_viewmodel.dart';
import 'package:app/widgets/card_streams/card_stream_view.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class ChannelsScreen extends StatelessWidget {
  final String _game;
  final String _gameId;

  const ChannelsScreen(
    this._game,
    this._gameId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChannelsViewModel>.reactive(
      viewModelBuilder: () => ChannelsViewModel(_gameId),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: AppText.heading4(
            _game,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: viewModel.isBusy
            ? Center(
                child: SpinKitDoubleBounce(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  key: PageStorageKey('ChannelsScreenList'),
                  scrollDirection: Axis.vertical,
                  children: viewModel.data!
                      .map(
                        (channel) => CardStreamView(
                          game: '',
                          username: channel.userName,
                          totalViewers: channel.viewerCount.toString(),
                          onTap: () =>
                              viewModel.startStreamerScreen(channel.userId),
                        ),
                      )
                      .toList(),
                ),
              ),
      ),
    );
  }
}
