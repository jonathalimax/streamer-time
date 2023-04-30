import 'package:app/features/event/widget/event_step_one_widget_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/styles/app_decorations.dart';
import 'package:design_system/widgets/app_button.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:design_system/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

class EventStepOneWidget extends StatelessWidget {
  final String? title;
  final TwitchGame? category;
  final String date;
  final String time;
  final String? imageUrl;
  final double width;
  final String callToActionTitle;
  final Function(String? title, TwitchGame? category) callToAction;

  final FocusNode _focusNode;
  final TextEditingController _titleController;
  final TextEditingController _categoryController;

  EventStepOneWidget({
    this.title,
    this.category,
    this.date = '',
    this.time = '',
    this.imageUrl,
    this.width = double.infinity,
    required this.callToActionTitle,
    required this.callToAction,
  })  : _titleController = TextEditingController(),
        _categoryController = TextEditingController(),
        _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventStepOneWidgetViewModel>.reactive(
      viewModelBuilder: () => EventStepOneWidgetViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.selectedTitle = this.title;
        if (title != null) _titleController.text = title!;
        if (category != null) {
          viewModel.selectedCategory = category;
          _categoryController.text = category!.name;
        }
      },
      builder: (context, viewModel, child) {
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
                      SizedBox(height: 4),
                      Container(
                        height: 230,
                        child: CardEventView(
                          title: viewModel.selectedTitle ?? 'Título do evento',
                          category: category?.name ??
                              viewModel.selectedCategory?.name ??
                              'Categoria',
                          date: date,
                          time: time,
                          width: double.infinity,
                          imageUrl: imageUrl,
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TypeAheadField<TwitchGame?>(
                          debounceDuration: Duration(milliseconds: 300),
                          textFieldConfiguration: TextFieldConfiguration(
                            autocorrect: false,
                            enableSuggestions: false,
                            onChanged: (_) {
                              viewModel.setCategory(null);
                            },
                            onEditingComplete: () {
                              viewModel.setCategory(null);
                            },
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _focusNode.requestFocus(),
                            textCapitalization: TextCapitalization.words,
                            controller: _categoryController,
                            scrollPadding: EdgeInsets.only(bottom: 200),
                            decoration: appInputTextDecoration(
                              context,
                              'Categoria',
                            ),
                          ),
                          suggestionsCallback: viewModel.getCategorySuggestion,
                          itemBuilder: (context, TwitchGame? game) {
                            return ListTile(
                              dense: true,
                              title: AppText.body(game?.name ?? ''),
                            );
                          },
                          onSuggestionSelected: (TwitchGame? game) {
                            if (game != null) {
                              _categoryController.text = game.name;
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
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AppTextField(
                          focusNode: _focusNode,
                          controller: _titleController,
                          placeholder: 'Título do evento',
                          onChanged: viewModel.setTitle,
                        ),
                      ),
                      Spacer(flex: 5),
                      SizedBox(
                        width: 290,
                        child: AppButton(
                          title: callToActionTitle,
                          action: () => callToAction(
                            viewModel.selectedTitle,
                            viewModel.selectedCategory,
                          ),
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
      },
    );
  }
}
