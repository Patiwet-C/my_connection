import 'package:flutter/material.dart';
import 'package:my_connection/base/base_bloc_state.dart';
import 'package:my_connection/features/home/blocs/settings_bloc.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/widgets/switch_tab_button.dart';
import 'package:my_connection/widgets/vgap.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState
    extends BaseBlocState<SettingsBloc, ISettingsBloc, SettingsPage>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: bloc.languageIndex,
    );
  }

  @override
  Widget buildPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const VGap(24),
          const Icon(Icons.settings, size: 100, color: Colors.blue),
          const VGap(20),
          Text(t.home.settings.title, style: styles.headline1),
          const VGap(20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text(t.home.settings.notifications),
                    trailing: Switch(value: true, onChanged: null),
                  ),
                  const Divider(),
                  StreamBuilder<bool>(
                    stream: bloc.isDarkMode,
                    builder: (_, snapshot) {
                      final bool isDarkMode = snapshot.data ?? false;

                      return ListTile(
                        leading: Icon(Icons.dark_mode),
                        title: Text(t.home.settings.dark_mode),
                        trailing: Switch(
                          value: isDarkMode,
                          onChanged: (bool value) =>
                              bloc.onDarkModeChanged(context, value),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(t.home.settings.language),
                    trailing: SwitchTabButton(
                      controller: tabController,
                      onTap: (int index) {
                        setState(() {
                          bloc.onLanguageChanged(index);
                        });
                      },
                      firstLabel: t.button.en,
                      secondLabel: t.button.th,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
