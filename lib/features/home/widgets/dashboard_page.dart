import 'package:flutter/material.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/widgets/vgap.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.dashboard, size: 100, color: Colors.blue),
          const VGap(20),
          Text(
            t.home.dashboard.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const VGap(10),
          Text(
            t.home.dashboard.description,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const VGap(30),
          ElevatedButton(
            onPressed: () {
              // Add your action here
            },
            child: Text(t.home.dashboard.get_started),
          ),
        ],
      ),
    );
  }
}
