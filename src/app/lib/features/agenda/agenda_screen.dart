import 'package:app/app/app.locator.dart';
import 'package:app/features/agenda/agenda_viewmodel.dart';
import 'package:app/widgets/agenda/agenda_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgendaViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<AgendaViewModel>(),
      builder: (context, viewModel, child) => _buildScreen(context),
    );
  }

  Scaffold _buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AgendaView(
              title: 'Gaules',
            ),
          ),
        ),
      ),
    );
  }
}
