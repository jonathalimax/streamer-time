import 'package:app/app/app.locator.dart';
import 'package:app/features/discover/discover_viewmodel.dart';
import 'package:app/widgets/card_event_widget.dart';
import 'package:app/widgets/card_game_widget.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewmodel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<DiscoverViewmodel>(),
      builder: (context, viewModel, child) => _buildScreen(context, viewModel),
    );
  }

  Widget _buildScreen(BuildContext context, DiscoverViewmodel viewModel) {
    return Scaffold(
      body: viewModel.isBusy
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            )
          : SafeArea(
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppText.heading4('Destaque'),
                    Flexible(
                      child: ListView(
                        key: PageStorageKey('EmphasisListKey'),
                        scrollDirection: Axis.horizontal,
                        children: viewModel.data!
                            .map(
                              (game) => CardGameWidget(
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
              ),
            ),
    );
  }
}
