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
              : viewModel.data == null
                  ? AppEmptyState(
                      title: 'Ocorreu um erro, tente novamente!',
                      type: AppEmptyStateType.noDocument,
                    )
                  : _buildItemList(context, viewModel),
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfileImageView(
                context: context,
                imageUrl: viewModel.data!.profileImageUrl,
                size: 75,
              ),
              SizedBox(width: 16),
              Flexible(
                child: AppText.heading4(
                  viewModel.data!.name,
                ),
              ),
            ],
          ),
        ),
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
}
