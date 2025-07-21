import 'package:flutter/material.dart';
import 'package:my_connection/base/base_stateless.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/widgets/custom_card.dart';
import 'package:my_connection/widgets/vgap.dart';

class ProfilePage extends BaseStateless {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: AppColour.onPrimary),
          ),
          const VGap(20),
          Text(t.home.profile.title, style: styles.headline1),
          const VGap(20),
          CustomCard(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(t.home.profile.email, style: styles.body1),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(t.home.profile.phone, style: styles.body1),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(t.home.profile.address, style: styles.body1),
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
