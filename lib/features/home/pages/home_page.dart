import 'package:flutter/material.dart';
import 'package:my_connection/base/base_bloc_state.dart';
import 'package:my_connection/features/home/blocs/home_bloc.dart';
import 'package:my_connection/features/home/widgets/dashboard_page.dart';
import 'package:my_connection/features/home/widgets/profile_page.dart';
import 'package:my_connection/features/home/widgets/settings_page.dart';
import 'package:my_connection/styles/app_colour.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseBlocState<HomeBloc, IHomeBloc, HomePage>
    with TickerProviderStateMixin {
  @override
  bool get isShowAppBar => true;

  @override
  Widget? getAppBarTitle() {
    return StreamBuilder(
      stream: bloc.selectedIndex,
      builder: (_, _) {
        return Text(translation.home.title, style: styles.body1);
      },
    );
  }

  @override
  Widget buildPageContent(BuildContext context) {
    final languageController = TabController(
      length: 2,
      vsync: this,
      initialIndex: bloc.languageIndex,
    );

    final darkModeController = TabController(
      length: 2,
      vsync: this,
      initialIndex: bloc.darkModeIndex,
    );

    return StreamBuilder<int>(
      stream: bloc.selectedIndex,
      builder: (_, snapshot) {
        final index = snapshot.data ?? 0;

        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: IndexedStack(
            index: index,
            children: <Widget>[
              const DashboardPage(),
              const ProfilePage(),
              SettingsPage(
                onDarkModeChanged: (int index) {
                  // NOTE: have to setstate to re-render screen
                  setState(() {
                    bloc.onDarkModeChanged(index);
                  });
                },
                onLanguageChanged: (int index) {
                  // NOTE: have to setstate to re-render screen
                  setState(() {
                    bloc.onLanguageChanged(index);
                  });
                },
                onLogout: bloc.logout,
                languageController: languageController,
                darkModeController: darkModeController,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget? getBottomNavigationBar() {
    return StreamBuilder<int>(
      stream: bloc.selectedIndex,
      builder: (_, snapshot) {
        return StreamBuilder<int>(
          stream: bloc.selectedIndex,
          builder: (_, snapshot) {
            final index = snapshot.data ?? 0;

            return BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: translation.home.tabbar_menu.dashboard,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: translation.home.tabbar_menu.profile,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: translation.home.tabbar_menu.settings,
                ),
              ],
              currentIndex: index,
              selectedItemColor: AppColour.primary,
              unselectedItemColor: AppColour.secondary,
              onTap: bloc.onTabSelected,
            );
          },
        );
      },
    );
  }
}
