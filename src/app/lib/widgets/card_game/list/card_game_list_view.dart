import 'package:app/app/app.locator.dart';
import 'package:app/widgets/card_streams/card_stream_view.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import 'card_game_list_viewmodel.dart';
import '../card_game_graphics_view.dart';

class CardGameListView extends StatelessWidget {
  final bool hasLoader;

  const CardGameListView({
    Key? key,
    this.hasLoader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardGameListViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<CardGameListViewModel>(),
      builder: (context, viewModel, child) => _buildList(context, viewModel),
    );
  }

  Widget _buildList(BuildContext context, CardGameListViewModel viewModel) {
    return LoadingOverlay(
      isLoading: viewModel.isBusy && hasLoader,
      color: Theme.of(context).scaffoldBackgroundColor,
      progressIndicator: SpinKitDoubleBounce(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: viewModel.dataReady
          ? Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppText.heading4('Categorias Populares'),
                  SizedBox(height: 4),
                  Flexible(
                    child: viewModel.isGraphicsboolEnabled
                        ? _buildGraphicsWidget(viewModel)
                        : _buildTitlesWidget(viewModel),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Widget _buildGraphicsWidget(CardGameListViewModel viewModel) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 200 / 326,
      mainAxisSpacing: 14,
      key: PageStorageKey('CardGameList'),
      scrollDirection: Axis.vertical,
      children: viewModel.data!
          .map(
            (game) => CardGameGraphicsView(
              game: game.name,
              imageUrl: game.getBoxArtUrl(
                width: 342,
                height: 524,
              ),
              onTap: () => viewModel.showChannelsBy(
                game.name,
                game.id,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTitlesWidget(CardGameListViewModel viewModel) {
    return ListView(
      key: PageStorageKey('ChannelsScreenList'),
      scrollDirection: Axis.vertical,
      children: viewModel.data!
          .map(
            (game) => CardStreamView(
              title: game.name,
              onTap: () => viewModel.showChannelsBy(
                game.name,
                game.id,
              ),
            ),
          )
          .toList(),
    );
  }
}
