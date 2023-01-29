import 'package:app/features/own_events/own_events_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/widgets/empty_state/app_empty_state.dart';
import 'package:design_system/widgets/empty_state/app_empty_state_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class OwnEventsScreen extends StatelessWidget {
  const OwnEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OwnEventsViewModel>.reactive(
      viewModelBuilder: () => OwnEventsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Meus Eventos',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: viewModel.isBusy
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : viewModel.data!.isNotEmpty
                  ? EventsWidget(viewModel)
                  : AppEmptyState(
                      title: 'Nenhum evento disponível!',
                      type: AppEmptyStateType.noDocument,
                    ),
        );
      },
    );
  }

  Padding EventsWidget(OwnEventsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: ListView.builder(
        itemCount: viewModel.data!.length,
        itemBuilder: (context, index) {
          final item = viewModel.data![index];
          return Container(
            height: 230,
            child: InkWell(
              onTap: () => viewModel.manageEvent(item),
              highlightColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.2),
              borderRadius: BorderRadius.all(Radius.circular(3)),
              child: CardEventView(
                category: item.categoryName,
                title: item.title,
                date: item.dateDisplay,
                time: item.timeDisplay,
                imageUrl: item.imageUrl,
                isLive: item.isLive,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
