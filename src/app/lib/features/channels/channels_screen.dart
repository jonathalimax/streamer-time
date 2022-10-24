import 'package:app/features/channels/channels_viewmodel.dart';
import 'package:app/widgets/card_streams/card_stream_view.dart';
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
          title: Text(
            _game,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: viewModel.isBusy
            ? Center(
                child: SpinKitDoubleBounce(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    key: PageStorageKey('ChannelsScreenList'),
                    scrollDirection: Axis.vertical,
                    children: viewModel.data!
                        .map(
                          (channel) => CardStreamView(
                            title: channel.userName,
                            totalViewers: channel.viewerCount.toString(),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            onTap: () => viewModel.startStreamerScreen(
                              channel.userId,
                              channel.userLogin,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
      ),
    );
  }
}
