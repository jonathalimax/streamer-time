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
                  Spacer(flex: 1),
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('resources/icons/sup-icon.png'),
                      // color: kcIceWhite,
                      width: 250,
                    ),
                  ),
                  Spacer(flex: 1),
                  Center(
                    child: AppText.heading3(
                      'Seu streamer está online?',
                      color: kcIceWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  AppText.heading4(
                    'Saiba mais sobre a agenda e \neventos dos seus streamers favoritos!',
                    color: kcIceWhite,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(flex: 5),
                  AppButton(
                    title: 'Entrar',
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
