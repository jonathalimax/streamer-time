import 'package:app/features/event/event_date/create_event_date_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/styles/app_colors.dart';
import 'package:design_system/widgets/app_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class CreateEventDateTimeScreen extends StatelessWidget {
  final CreateEventDateViewModel viewModel;

  const CreateEventDateTimeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventDateViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Novo evento',
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Container(
                              height: 230,
                              child: CardEventView(
                                category: viewModel.category.name,
                                title: viewModel.title,
                                date: viewModel.selectedDateFormated,
                                time: viewModel.selectedTimeFormated,
                                width: double.infinity,
                                fontColor: kcIceWhite,
                                imageFile: viewModel.selectedImage,
                              ),
                            ),
                            SizedBox(height: 24),
                            SizedBox(
                              width: 290,
                              child: AppButton(
                                title: 'Adicionar data e hora',
                                action: () => viewModel.setDateTime(context),
                                color: Colors.transparent,
                                titleColor: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: 290,
                              child: AppButton(
                                title: 'Adicionar imagem de fundo',
                                action: () => viewModel
                                    .showImageSourceActionSheet(context),
                                color: Colors.transparent,
                                titleColor: Theme.of(context).primaryColor,
                              ),
                            ),
                            Spacer(flex: 5),
                            SizedBox(
                              width: 290,
                              child: AppButton(
                                title: 'Continuar',
                                action: () => viewModel.createEvent(context),
                                color: Colors.transparent,
                                titleColor: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
