import 'package:app/features/discover/discover_viewmodel.dart';
import 'package:app/widgets/card_game/card_game_list_view.dart';
import 'package:app/widgets/card_streams/card_stream_list_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewmodel>.nonReactive(
      viewModelBuilder: () => DiscoverViewmodel(),
      builder: (context, viewModel, child) => _buildScreen(context, viewModel),
    );
  }

  Widget _buildScreen(BuildContext context, DiscoverViewmodel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CardStreamListView(),
            CardGameListView(),
          ],
        ),
      ),
    );
  }
}
