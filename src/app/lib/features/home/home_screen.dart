import 'package:animations/animations.dart';
import 'package:app/features/agenda/agenda_screen.dart';
import 'package:app/features/discover/discover_screen.dart';
import 'package:app/features/home/home_viewmodel.dart';
import 'package:app/features/profile/profile_screen.dart';
import 'package:design_system/widgets/app_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => _buildScreen(
        context,
        viewModel,
      ),
    );
  }

  Scaffold _buildScreen(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return Scaffold(
      body: PageTransitionSwitcher(
        reverse: viewModel.reverse,
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            child: child,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
          );
        },
        child: _getScreenForIndex(viewModel.currentIndex),
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: viewModel.currentIndex,
        indexChanged: viewModel.setIndex,
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 25),
        items: [
          BottomNavigationBarItem(
            label: 'Eventos',
            icon: Icon(Icons.event_note),
          ),
          BottomNavigationBarItem(
            label: 'Descobrir',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return AgendaScreen();
      case 1:
        return DiscoverScreen();
      case 2:
        return ProfileScreen();
      default:
        return AgendaScreen();
    }
  }
}
