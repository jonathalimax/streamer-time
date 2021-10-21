import 'package:app/features/agenda/agenda_viewmodel.dart';
import 'package:app/widgets/agenda/agenda_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgendaViewModel>.reactive(
      // disposeViewModel: false,
      // initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => AgendaViewModel(),
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
                : ListView.builder(
                    itemCount:
                        viewModel.data == null ? 0 : viewModel.data!.length,
                    itemBuilder: (context, index) {
                      return viewModel.data![index].events.isNotEmpty
                          ? AgendaView(
                              title: viewModel.data![index].name,
                              events: viewModel.data![index].events,
                              profileImageUrl:
                                  viewModel.data![index].profileImageUrl,
                              onEventTap: () => viewModel.openStreamerWebview(
                                viewModel.data![index].username,
                              ),
                              onStreamerTap: () => viewModel.openStreamerScreen(
                                viewModel.data![index].id,
                              ),
                            )
                          : Container();
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
