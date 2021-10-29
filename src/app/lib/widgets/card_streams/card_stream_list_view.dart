import 'package:app/app/app.locator.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import 'card_stream_list_viewmodel.dart';
import 'card_stream_view.dart';

class CardStreamListView extends StatelessWidget {
  final bool hasLoader;

  const CardStreamListView({
    Key? key,
    this.hasLoader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardStreamListViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<CardStreamListViewModel>(),
      builder: (context, viewModel, child) => _buildList(context, viewModel),
    );
  }

  Widget _buildList(BuildContext context, CardStreamListViewModel viewModel) {
    final shouldLoad = viewModel.isBusy && hasLoader;
    final hasData = viewModel.data?.isNotEmpty ?? false;
    return Container(
      height: shouldLoad || hasData ? 120 : 0,
      child: LoadingOverlay(
        isLoading: shouldLoad,
        color: Theme.of(context).scaffoldBackgroundColor,
        progressIndicator: SpinKitDoubleBounce(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: viewModel.dataReady
            ? Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppText.heading4('Canais Sugeridos'),
                    SizedBox(height: 4),
                    Flexible(
                      child: ListView(
                        key: PageStorageKey('CardStreamList'),
                        scrollDirection: Axis.horizontal,
                        children: viewModel.data!
                            .map(
                              (channel) => CardStreamView(
                                game: channel.gameName,
                                username: channel.userName,
                                totalViewers: channel.viewerCount.toString(),
                                onTap: () => viewModel.startStreamerScreen(
                                  channel.userId,
                                  channel.userName,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
