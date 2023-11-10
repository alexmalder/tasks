import 'package:videos/controller/navigation_cubit.dart';
import 'package:videos/navigation/named_nav_bar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:videos/services/sign_service.dart';

import '../core/constants.dart';

// @task add global state for navigation[state]
class MainScreen extends StatelessWidget {
  final Widget screen;
  late bool isSigned = false;


  Future<void> fetchArtifacts() async {
    final bool response = await SignService.loadUserInfo();
    isSigned = response;
  }

  MainScreen({Key? key, required this.screen}) : super(key: key);

  List<NamedNavigationBarItemWidget> getTabs() {
    final List<NamedNavigationBarItemWidget> myTabs;
    if (isSigned) {
      myTabs = [
        NamedNavigationBarItemWidget(
          initialLocation: Routes.homeNamedPage,
          icon: const Icon(Icons.home),
          label: 'Home',
        ),
        NamedNavigationBarItemWidget(
          initialLocation: Routes.profileNamedPage,
          icon: const Icon(Icons.person),
          label: 'Profile',
        ),
        NamedNavigationBarItemWidget(
          initialLocation: Routes.settingsNamedPage,
          icon: const Icon(Icons.settings),
          label: 'Setting',
        ),
      ];
    } else {
      myTabs = [
        NamedNavigationBarItemWidget(
          initialLocation: Routes.signInPage,
          icon: const Icon(Icons.account_box),
          label: 'Sign In',
        ),
        NamedNavigationBarItemWidget(
          initialLocation: Routes.info,
          icon: const Icon(Icons.info),
          label: 'Info',
        ),
        NamedNavigationBarItemWidget(
            initialLocation: Routes.mobxTest,
            icon: const Icon(Icons.add_business),
            label: "Mobx Test"
        )
      ];
    }
    return myTabs;
  }

  @override
  Widget build(BuildContext context) {
    if (!isSigned) {
      context.go(Routes.signInPage);
    }
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, getTabs()),
    );
  }
}

BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(mContext, List<NamedNavigationBarItemWidget>tabs) =>
    BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (value) {
            if(state.index != value){
              context.read<NavigationCubit>().getNavBarItem(value);
              context.go(tabs[value].initialLocation);
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            size: ((IconTheme
                .of(mContext)
                .size)! * 1.3),
          ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
