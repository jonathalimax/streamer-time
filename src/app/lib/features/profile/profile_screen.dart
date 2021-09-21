import 'package:app/app/app.locator.dart';
import 'package:app/features/profile/profile_viewmodel.dart';
import 'package:app/widgets/profile_image_view.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          body: viewModel.isBusy
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: viewModel.data == null
                        ? AppEmptyState(
                            title: 'Ocorreu um erro, tente novamente!',
                            type: AppEmptyStateType.noDocument,
                          )
                        : Column(
                            children: <Widget>[
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ProfileImageView(
                                    context: context,
                                    imageUrl: viewModel.data!.profileImageUrl,
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: AppText.heading3(
                                      viewModel.data!.name,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
        );
      },
    );
  }
}
