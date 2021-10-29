import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class DiscoverSearchDelegate extends SearchDelegate<String> {
  final _twitchService = locator<TwitchService>();
  final _navigationService = locator<NavigationService>();

  DiscoverSearchDelegate() : super(searchFieldLabel: 'Buscar streamer');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: Icon(
          Icons.clear_rounded,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _twitchService.client.searchChannels(query: query),
      builder: (context,
          AsyncSnapshot<TwitchResponse<TwitchSearchChannel>> snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          case ConnectionState.done:
            if (!snapshot.hasData || snapshot.data!.data!.isEmpty)
              return AppEmptyState(
                title: 'Nenhum streamer encontrado!',
                type: AppEmptyStateType.noSearchResult,
              );

            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return _buildSearchList(
                  context,
                  snapshot.data!.data![index],
                );
              },
            );
          default:
            return Container(
              color: Colors.black,
            );
        }
      },
    );
  }

  Widget _buildSearchList(
    BuildContext context,
    TwitchSearchChannel channel,
  ) {
    return InkWell(
      onTap: () {
        _navigationService.navigateTo(
          Routes.streamerScreen,
          arguments: StreamerScreenArguments(
            viewModel: StreamerViewModel(
              streamerId: channel.id,
              username: channel.broadcasterLogin,
            ),
          ),
        );
      },
      highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(.2),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          foregroundImage: CachedNetworkImageProvider(
            channel.thumbnailUrl,
          ),
        ),
        title: AppText.body(
          channel.displayName,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
