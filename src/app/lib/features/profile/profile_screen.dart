import 'package:app/app/app.locator.dart';
import 'package:app/features/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<ProfileViewModel>(),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            actions: [
              IconButton(
                onPressed: viewModel.logout,
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        );
      },
    );
  }
}
