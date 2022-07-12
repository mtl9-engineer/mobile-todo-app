import 'package:flutter/material.dart';
import 'package:todolist/view/components/settings_tile.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text("Settings",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsTile(
                  isProfile: true,
                  title: 'Taoufik Lahmidi',
                  leadingIcon: Icons.person),
              const SizedBox(
                height: 20,
              ),
              SettingsTile(
                  isProfile: false,
                  title: 'My Daily',
                  leadingIcon: Icons.star_half_sharp),
              SettingsTile(
                  isProfile: false,
                  title: 'Calendar & Planned',
                  leadingIcon: Icons.calendar_month),
              SettingsTile(
                  isProfile: false,
                  title: 'Connect with me',
                  leadingIcon: Icons.supervised_user_circle),
              const SizedBox(
                height: 20,
              ),
              const Text('My List Task',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              SettingsTile(
                  isProfile: false,
                  title: 'Money Saver',
                  leadingIcon: Icons.list_alt_sharp),
              SettingsTile(
                  isProfile: false,
                  title: 'Money Expedenture',
                  leadingIcon: Icons.list_alt_sharp),
              
            ],
          ),
        ),
      ),
    ));
  }
}
