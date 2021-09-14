import 'package:app/features/streamer/streamer_viewmodel.dart';
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
        child: viewModel.fetchingStreamer
            ? SpinKitDoubleBounce(
                color: Theme.of(context).colorScheme.secondary,
              )
            : Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: AppText.body(
                            viewModel.fetchedStreamer?.description ?? '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, StreamerViewModel viewModel) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: viewModel.fetchingStreamer
          ? Container()
          : AppText.heading4(
              viewModel.fetchedStreamer?.displayName ?? '',
              color: Colors.white,
            ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            child: ClipOval(
              child: _buildProfileImage(viewModel),
            ),
            backgroundColor: Colors.transparent,
          ),
        )
      ],
    );
  }

  Widget _buildProfileImage(StreamerViewModel viewModel) {
    if (viewModel.fetchingStreamer) return Container();
    return CachedNetworkImage(
      imageUrl: viewModel.fetchedStreamer?.profileImageUrl ?? '',
      placeholder: (context, url) => Center(
        child: SpinKitDoubleBounce(
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
