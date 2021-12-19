import 'package:app/app/app.locator.dart';
import 'package:app/features/profile/profile_viewmodel.dart';
import 'package:app/features/profile/widget/profile_item_widget.dart';
import 'package:app/widgets/profile_image_view.dart';
import 'package:design_system/design_system.dart';
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
          ),
          body: viewModel.isBusy
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : SafeArea(
                  child: viewModel.data == null
                      ? AppEmptyState(
                          title: 'Ocorreu um erro, tente novamente!',
                          type: AppEmptyStateType.noDocument,
                        )
                      : _buildItemList(context, viewModel),
                ),
        );
      },
    );
  }

  ListView _buildItemList(
    BuildContext context,
    ProfileViewModel viewModel,
  ) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfileImageView(
                context: context,
                imageUrl: viewModel.data!.profileImageUrl,
                size: 75,
              ),
              SizedBox(width: 30),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildStats(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppText.heading4(
            viewModel.data!.name,
          ),
        ),
        SizedBox(height: 10),
        Divider(),
        ProfileItemWidget(
          title: 'Seguindo',
          leading: Icon(Icons.favorite),
          onTap: viewModel.showFavorites,
        ),
        ProfileItemWidget(
          title: 'Meus eventos',
          leading: Icon(Icons.event_note),
          onTap: viewModel.showEvents,
        ),
        ProfileItemWidget(
          title: 'Sair da conta',
          leading: Icon(Icons.logout),
          onTap: viewModel.logout,
        ),
      ],
    );
  }

  // TODO: Populate stats
  Widget _buildStats() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppText.bodyBold('120'),
            AppText.bodyBold('Seguidores'),
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: <Widget>[
            AppText.bodyBold('4'),
            AppText.bodyBold('Seguindo'),
          ],
        ),
      ],
    );
  }
}
