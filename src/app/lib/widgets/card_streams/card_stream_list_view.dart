import 'package:app/app/app.locator.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'card_stream_list_viewmodel.dart';
import 'card_stream_view.dart';

class CardStreamListView extends StatelessWidget {
  const CardStreamListView({
    Key? key,
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
    return viewModel.isBusy || !viewModel.dataReady
        ? SizedBox(
            height: 130,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(8.0),
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppText.heading4('Canais Sugeridos'),
                Flexible(
                  child: ListView(
                    key: PageStorageKey('CardStreamList'),
                    scrollDirection: Axis.horizontal,
                    children: viewModel.data!
                        .map(
                          (game) => CardStreamView(
                            game: game.gameName,
                            username: game.userName,
                            totalViewers: game.viewerCount.toString(),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
  }
}
