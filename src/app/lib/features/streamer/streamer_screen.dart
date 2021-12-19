import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/widgets/agenda/agenda_view.dart';
import 'package:app/widgets/profile_image_view.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
                  StreamerBioWidget(viewModel: viewModel),
                  if (viewModel.fetchedStreamer != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: viewModel.fetchedStreamer!.events.isNotEmpty
                          ? AgendaView(
                              title: 'Agenda',
                              events: viewModel.fetchedStreamer!.events,
                            )
                          : Container(),
                    ),
                  Spacer(),
                  Container(
                    height: viewModel.bannerAd.size.height.toDouble(),
                    child: AdWidget(
                      ad: viewModel.bannerAd,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, StreamerViewModel viewModel) {
    return AppBar(
      actions: [
        viewModel.isBusy
            ? SpinKitPulse(
                color: kcIceWhite,
              )
            : IconButton(
                onPressed: () {
                  if (viewModel.fetchedStreamer == null) return;
                  viewModel.fetchedStreamer!.following
                      ? viewModel.unfollowStreamer()
                      : viewModel.followStreamer();
                },
                icon: Icon(
                  viewModel.fetchedStreamer?.following ?? false
                      ? Icons.favorite
                      : Icons.favorite_outline,
                ),
              )
      ],
    );
  }
}

class StreamerBioWidget extends StatelessWidget {
  final StreamerViewModel viewModel;

  const StreamerBioWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (viewModel.fetchedStreamer != null)
                ProfileImageView(
                  context: context,
                  imageUrl: viewModel.fetchedStreamer!.profileImageUrl,
                ),
              SizedBox(width: 10),
              viewModel.fetchingStreamer
                  ? Container()
                  : AppText.heading3(
                      viewModel.fetchedStreamer?.name ?? '',
                    ),
            ],
          ),
          SizedBox(height: 12),
          Flexible(
            fit: FlexFit.loose,
            child: AppText.body(
              viewModel.fetchedStreamer?.description ?? '',
              textAlign: TextAlign.left,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
