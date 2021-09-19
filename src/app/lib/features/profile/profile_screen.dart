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
            title: Text(
              'Perfil',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
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
