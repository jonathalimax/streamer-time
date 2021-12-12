import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/app_button.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

import 'create_event_step_one_viewmodel.dart';

class CreateEventStepOneScreen extends StatelessWidget {
  final FocusNode _focusNode;
  final TextEditingController _controller;

  CreateEventStepOneScreen()
      : _controller = TextEditingController(),
        _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventStepOneViewModel>.reactive(
      viewModelBuilder: () => CreateEventStepOneViewModel(),
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
            : _buildBody(viewModel, context),
      ),
    );
  }

  Widget _buildBody(
    CreateEventStepOneViewModel viewModel,
    BuildContext context,
  ) {
    return SafeArea(
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
                      category: viewModel.selectedCategory?.name ?? 'Categoria',
                      title: viewModel.selectedTitle ?? 'Título do evento',
                      date: "",
                      time: "",
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 24),
                  buildCategorySearch(context, viewModel),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: AppTextField(
                      focusNode: _focusNode,
                      placeholder: 'Título do evento',
                      onChanged: viewModel.setTitle,
                    ),
                  ),
                  Spacer(flex: 5),
                  SizedBox(
                    width: 290,
                    child: AppButton(
                      title: 'Continuar',
                      action: () => viewModel.continueCreatingEvent(),
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
    );
  }

  Padding buildCategorySearch(
      BuildContext context, CreateEventStepOneViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TypeAheadField<TwitchGame?>(
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => _focusNode.requestFocus(),
          controller: _controller,
          scrollPadding: EdgeInsets.only(bottom: 150),
          decoration: appInputTextDecoration(
            context,
            'Categoria',
          ),
        ),
        suggestionsCallback: viewModel.getCategorySuggestion,
        itemBuilder: (context, TwitchGame? game) {
          return ListTile(
            dense: true,
            title: AppText.body(
              game?.name ?? '',
            ),
          );
        },
        onSuggestionSelected: (TwitchGame? game) {
          if (game != null) {
            _controller.text = game.name;
            viewModel.setCategory(game);
          }
        },
        loadingBuilder: (context) {
          return SpinKitDoubleBounce(
            color: Theme.of(context).colorScheme.secondary,
          );
        },
        noItemsFoundBuilder: (context) {
          return Container(
            height: 40,
            child: Center(
              child: AppText.body(
                'Nenhuma categoria encontrada!',
              ),
            ),
          );
        },
      ),
    );
  }
}
