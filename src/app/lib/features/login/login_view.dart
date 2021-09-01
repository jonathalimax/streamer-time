import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => buildScreen(context),
    );
  }

  Widget buildScreen(BuildContext context) {
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
                      image: AssetImage('resources/icons/twitch-logo.png'),
                      color: kcIceWhite,
                      width: 120,
                    ),
                  ),
                  Spacer(flex: 2),
                  AppText.heading2(
                    'Cadê o meu streamer?',
                    color: kcIceWhite,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  AppText.heading4(
                    'Não se preocupe, te informamos quando eles estarão em live!',
                    color: kcIceWhite,
                  ),
                  Spacer(flex: 5),
                  AppButton(
                    title: 'Entrar',
                    action: () {},
                    titleColor: kcPurple,
                  ),
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
