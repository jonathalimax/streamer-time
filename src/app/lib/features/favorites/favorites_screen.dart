import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:design_system/widgets/empty_state/app_empty_state.dart';
import 'package:design_system/widgets/empty_state/app_empty_state_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'favorites_viewmodel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      viewModelBuilder: () => FavoritesViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Meus favoritos',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: _buildBody(viewModel, context),
      ),
    );
  }

  Widget _buildBody(FavoritesViewModel viewModel, BuildContext context) {
    return viewModel.isBusy
        ? Center(
            child: SpinKitDoubleBounce(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : SafeArea(
            child: viewModel.users.isEmpty
                ? AppEmptyState(
                    title: 'Você ainda não possui streamers favoritos!',
                    type: AppEmptyStateType.noDocument,
                  )
                : ListView.builder(
                    itemCount: viewModel.users.length,
                    itemExtent: 60,
                    itemBuilder: (context, index) {
                      final user = viewModel.users[index];
                      return Center(
                        child: InkWell(
                          onTap: () => viewModel.openStreamerDetails(
                            user.id,
                            user.username,
                          ),
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(.2),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundImage: CachedNetworkImageProvider(
                                user.profileImageUrl,
                              ),
                            ),
                            title: AppText.body(
                              user.username,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
  }
}