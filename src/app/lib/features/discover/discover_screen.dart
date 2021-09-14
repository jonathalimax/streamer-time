import 'package:app/app/app.locator.dart';
import 'package:app/features/discover/discover_search_delegate.dart';
import 'package:app/features/discover/discover_viewmodel.dart';
import 'package:app/widgets/card_game/card_game_list_view.dart';
import 'package:app/widgets/card_streams/card_stream_list_view.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: AppBar(
        title: AppText.heading4(
          'Descobrir',
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          _buildAppBarActions(context),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CardStreamListView(
                hasLoader: true,
              ),
              SizedBox(height: 4),
              Flexible(
                fit: FlexFit.loose,
                child: CardGameListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _buildAppBarActions(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: DiscoverSearchDelegate(),
        );
      },
      icon: Icon(
        Icons.search,
        color: kcIceWhite,
      ),
    );
  }
}
