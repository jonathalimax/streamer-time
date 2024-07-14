import 'package:animations/animations.dart';
import 'package:app/features/discover/discover_screen.dart';
import 'package:app/features/home/home_viewmodel.dart';
import 'package:app/features/lives/lives_screen.dart';
import 'package:app/features/profile/profile_screen.dart';
import 'package:design_system/widgets/app_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

enum TabItem { lives, discover, profile }

extension TabItemExtension on TabItem {
  int get index {
    switch (this) {
      case TabItem.lives:
        return 0;
      case TabItem.discover:
        return 1;
      case TabItem.profile:
        return 2;
      default:
        return 0;
    }
  }

  String get title {
    switch (this) {
      case TabItem.lives:
        return 'Lives';
      case TabItem.discover:
        return 'Descobrir';
      case TabItem.profile:
        return 'Perfil';
      default:
        return '';
    }
  }
}

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
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            child: child,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
          );
        },
        child: _getScreenForIndex(viewModel),
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: viewModel.currentIndex,
        indexChanged: viewModel.setIndex,
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 25),
        items: [
          BottomNavigationBarItem(
            label: TabItem.lives.title,
            icon: Icon(Icons.event_note),
          ),
          BottomNavigationBarItem(
            label: TabItem.discover.title,
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: TabItem.profile.title,
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Widget _getScreenForIndex(HomeViewModel viewModel) {
    switch (viewModel.currentIndex) {
      case 0:
        return LivesScreen(
            changePage: (tabItem) => viewModel.setIndex(tabItem.index));
      case 1:
        return DiscoverScreen();
      case 2:
        return ProfileScreen();
      default:
        return LivesScreen(
            changePage: (tabItem) => viewModel.setIndex(tabItem.index));
    }
  }
}
