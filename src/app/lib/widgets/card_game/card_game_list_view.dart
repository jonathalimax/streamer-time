import 'package:app/app/app.locator.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'card_game_list_viewmodel.dart';
import 'card_game_view.dart';

class CardGameListView extends StatelessWidget {
  const CardGameListView({Key? key}) : super(key: key);

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
    return viewModel.isBusy
        ? SizedBox(
            height: 600,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                AppText.heading4('Categorias Populares'),
                Container(
                  height: 500,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 250 / 170,
                    key: PageStorageKey('CardGameList'),
                    scrollDirection: Axis.horizontal,
                    children: viewModel.data!
                        .map(
                          (game) => CardGameView(
                            game: game.name,
                            imageUrl: game.getBoxArtUrl(
                              width: 200,
                              height: 300,
                            ),
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
