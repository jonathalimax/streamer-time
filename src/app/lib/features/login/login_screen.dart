import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => buildScreen(
        context,
        viewModel,
      ),
    );
  }

  Widget buildScreen(
    BuildContext context,
    LoginViewModel viewModel,
  ) {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(flex: 2),
                  Center(
                    child: Image(
                      image: AssetImage('resources/icons/liveus-icon.png'),
                      width: 260,
                    ),
                  ),
                  Spacer(flex: 1),
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: AppText.heading3(
                        'Você sempre atualizado!',
                        color: kcIceWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: AppText.heading4(
                        'Fique por dentro da agenda \ndos seus streamers favoritos!',
                        color: kcIceWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  AppButton(
                    title: 'Utilizar conta Twitch',
                    action: () => viewModel.startAuthentication(),
                    titleColor: kcPurple,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kcLightPurple, kcPurple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
