import 'package:flutter/material.dart';
import 'package:my_connection/base/base_stateless.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/widgets/custom_button.dart';
import 'package:my_connection/widgets/custom_card.dart';
import 'package:my_connection/widgets/custom_switch.dart';
import 'package:my_connection/widgets/switch_tab_button.dart';
import 'package:my_connection/widgets/vgap.dart';

class SettingsPage extends BaseStateless {
  final Function(int) onDarkModeChanged;
  final Function(int) onLanguageChanged;
  final Function() onLogout;
  final TabController languageController;
  final TabController darkModeController;

  const SettingsPage({
    super.key,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
    required this.onLogout,
    required this.languageController,
    required this.darkModeController,
  });

  @override
  Widget build(BuildContext context) {
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
          CustomCard(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text(t.home.settings.notifications),
                    trailing: CustomSwitch(
                      value: false,
                      onChanged: (bool value) {},
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.dark_mode),
                    title: Text(t.home.settings.dark_mode),
                    trailing: SwitchTabButton(
                      controller: darkModeController,
                      onTap: onDarkModeChanged,
                      firstLabel: t.button.on,
                      secondLabel: t.button.off,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(t.home.settings.language),
                    trailing: SwitchTabButton(
                      controller: languageController,
                      onTap: onLanguageChanged,
                      firstLabel: t.button.en,
                      secondLabel: t.button.th,
                    ),
                  ),
                  const Divider(),
                  CustomButton(
                    label: 'logout',
                    onPressed: onLogout,
                    isFullWidth: true,
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
