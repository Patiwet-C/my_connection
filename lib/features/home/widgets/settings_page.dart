import 'package:flutter/material.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/styles/app_text_styles.dart';
import 'package:my_connection/widgets/switch_tab_button.dart';
import 'package:my_connection/widgets/vgap.dart';

class SettingsPage extends StatelessWidget {
  final Stream<bool> isDarkMode;
  final Function(bool) onDarkModeChanged;
  final Function(int) onLanguageChanged;
  final TabController tabController;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles.get();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const VGap(24),
          Icon(Icons.settings, size: 100, color: AppColour.primary),
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
                    stream: isDarkMode,
                    builder: (_, snapshot) {
                      final bool isDarkMode = snapshot.data ?? false;

                      return ListTile(
                        leading: Icon(Icons.dark_mode),
                        title: Text(t.home.settings.dark_mode),
                        trailing: Switch(
                          value: isDarkMode,
                          onChanged: onDarkModeChanged,
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
                      onTap: onLanguageChanged,
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
