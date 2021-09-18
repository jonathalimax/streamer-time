import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/widgets/agenda/agenda_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class StreamerScreen extends StatelessWidget {
  final StreamerViewModel viewModel;

  const StreamerScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamerViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (context, viewModel, _) => _buildScreen(context, viewModel),
    );
  }

  Scaffold _buildScreen(BuildContext context, StreamerViewModel viewModel) {
    return Scaffold(
      appBar: _buildAppBar(context, viewModel),
      body: SafeArea(
        child: viewModel.fetchingStreamer || viewModel.fetchingAgenda
            ? SpinKitDoubleBounce(
                color: Theme.of(context).colorScheme.secondary,
              )
            : Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _buildProfileImage(context, viewModel),
                              SizedBox(width: 6),
                              viewModel.fetchingStreamer
                                  ? Container()
                                  : AppText.heading3(
                                      viewModel.fetchedStreamer?.displayName ??
                                          '',
                                    ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Flexible(
                            child: AppText.body(
                              viewModel.fetchedStreamer?.description ?? '',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: AgendaView(title: 'Agenda'),
                  ),
                  Spacer(),
                ],
              ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, StreamerViewModel viewModel) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_outline,
          ),
        )
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, StreamerViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
          width: 2.0,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: viewModel.fetchedStreamer?.profileImageUrl ?? '',
            placeholder: (context, url) => Center(
              child: SpinKitDoubleBounce(
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
