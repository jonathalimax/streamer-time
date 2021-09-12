import 'package:app/app/app.locator.dart';
import 'package:app/services/twitch_service.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitch_api/twitch_api.dart';

class DiscoverSearchDelegate extends SearchDelegate<String> {
  final _twitchService = locator<TwitchService>();

  DiscoverSearchDelegate() : super(searchFieldLabel: 'Buscar streamer');
  @override
  List<Widget>? buildActions(BuildContext context) {
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
  Widget? buildLeading(BuildContext context) {
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
                color: Theme.of(context).accentColor,
              ),
            );
          case ConnectionState.done:
            if (!snapshot.hasData || snapshot.data!.data!.isEmpty)
              return AppEmptyState(
                title: 'Nenhum streamer foi encontrado!',
                type: AppEmptyStateType.noSearchResult,
              );

            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return _buildSearchList(snapshot.data!, index);
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

  ListTile _buildSearchList(
    TwitchResponse<TwitchSearchChannel> snapshot,
    int index,
  ) {
    return ListTile(
      title: AppText.body(
        snapshot.data![index].displayName,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
