import 'package:app/features/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class StartupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, viewModel, child) => _buildScreen(context),
      onViewModelReady: (viewModel) =>
          SchedulerBinding.instance.addPostFrameCallback(
        (timeStamp) {
          viewModel.runStartupLogic();
        },
      ),
    );
  }

  Scaffold _buildScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
