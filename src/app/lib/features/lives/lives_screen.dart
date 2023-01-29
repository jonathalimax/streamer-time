import 'package:app/app/app.locator.dart';
import 'package:app/features/home/home_screen.dart';
import 'package:app/features/lives/lives_viewmodel.dart';
import 'package:app/widgets/agenda/agenda_view.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

class LivesScreen extends StatelessWidget {
  const LivesScreen({
    Key? key,
    required this.changePage,
  }) : super(key: key);

  final void Function(TabItem) changePage;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LivesViewModel>.reactive(
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<LivesViewModel>(),
      builder: (context, viewModel, child) => _buildScreen(
        context,
        viewModel,
      ),
    );
  }

  Scaffold _buildScreen(
    BuildContext context,
    LivesViewModel viewModel,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lives',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => viewModel.startCreateEvent(),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: viewModel.isBusy
                ? SpinKitDoubleBounce(
                    color: Theme.of(context).colorScheme.secondary,
                  )
                : viewModel.store.streamers.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          _buildAgendaList(viewModel),
                          _buildAdBanner(viewModel)
                        ],
                      )
                    : AppEmptyState(
                        title: 'Não há lives disponíveis!',
                        type: AppEmptyStateType.noDocument,
                        buttonTitle: 'Buscar streamers',
                        buttonAction: () => changePage(TabItem.discover),
                        refreshAction: () => viewModel.fetchStreamers(),
                      ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdBanner(LivesViewModel viewModel) {
    if (viewModel.bannerAd == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        height: viewModel.bannerAd!.size.height.toDouble(),
        child: AdWidget(
          ad: viewModel.bannerAd!,
        ),
      ),
    );
  }

  Widget _buildAgendaList(LivesViewModel viewModel) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => viewModel.fetchStreamers(),
        child: Observer(
          builder: (_) => ListView.builder(
            itemCount: viewModel.store.streamers.length,
            itemBuilder: (context, index) {
              var item = viewModel.store.streamers.elementAt(index);

              return item.events.isNotEmpty
                  ? AgendaView(
                      title: item.username,
                      events: item.events,
                      profileImageUrl: item.profileImageUrl,
                      onEventTap: () => viewModel.openStreamerWebview(
                        context,
                        item.username,
                      ),
                      onStreamerTap: () => viewModel.openStreamerScreen(
                        item.id,
                        item.username,
                      ),
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }
}
