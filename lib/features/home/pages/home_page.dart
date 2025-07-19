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
      stream: bloc.languageChanged,
      builder: (_, _) {
        return Text(translation.home.title, style: styles.body1);
      },
    );
  }

  @override
  Widget buildPageContent(BuildContext context) {
    return StreamBuilder<int>(
      stream: bloc.languageChanged,
      builder: (_, snapshot) {
        final languageIndex = snapshot.data ?? 0;

        final tabController = TabController(
          length: 2,
          vsync: this,
          initialIndex: languageIndex,
        );

        return StreamBuilder<int>(
          stream: bloc.selectedIndex,
          builder: (_, snapshot) {
            final index = snapshot.data ?? 0;

            return [
              DashboardPage(),
              ProfilePage(),
              SettingsPage(
                isDarkMode: bloc.isDarkMode,
                onDarkModeChanged: bloc.onDarkModeChanged,
                onLanguageChanged: bloc.onLanguageChanged,
                tabController: tabController,
              ),
            ].elementAt(index);
          },
        );
      },
    );
  }

  @override
  Widget? getBottomNavigationBar() {
    return StreamBuilder<int>(
      stream: bloc.languageChanged,
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
