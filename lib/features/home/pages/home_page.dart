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

class _HomePageState extends BaseBlocState<HomeBloc, IHomeBloc, HomePage> {
  final List<Widget> _pages = <Widget>[
    DashboardPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  String getPageTitle() {
    return translation.home.title;
  }

  @override
  Widget buildPageContent(BuildContext context) {
    return StreamBuilder<int>(
      stream: bloc.selectedIndex,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final int index = snapshot.data ?? 0;

        return _pages.elementAt(index);
      },
    );
  }

  @override
  Widget? getBottomNavigationBar() {
    return StreamBuilder<int>(
      stream: bloc.selectedIndex,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final int index = snapshot.data ?? 0;

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
  }
}
