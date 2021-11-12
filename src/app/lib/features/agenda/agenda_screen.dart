import 'package:app/app/app.locator.dart';
import 'package:app/features/agenda/agenda_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/widgets/agenda/agenda_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgendaViewModel>.reactive(
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      onModelReady: (viewModel) {
        viewModel.buildInlineBannerAd();
      },
      viewModelBuilder: () => locator<AgendaViewModel>(),
      builder: (context, viewModel, child) => _buildScreen(context, viewModel),
    );
  }

  Scaffold _buildScreen(
    BuildContext context,
    AgendaViewModel viewModel,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventos',
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
                : _buildAgendaList(viewModel),
          ),
        ),
      ),
    );
  }

  ListView _buildAgendaList(AgendaViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.items.length,
      itemBuilder: (context, index) {
        var item = viewModel.items[index];

        if (item is User) {
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
              : Container(); // TODO: Handle emtpy UI

        } else if (item is BannerAd) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: viewModel.bannerAd.size.height.toDouble(),
              child: AdWidget(
                ad: viewModel.bannerAd,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
