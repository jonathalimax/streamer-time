import 'package:app/features/splash/splash_viewmodel.dart';
import 'package:design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (viewModel) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => viewModel.runAnimation(),
        );
      },
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  child: LottieBuilder.asset(
                    'resources/lottie/splash-lottie.json',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
