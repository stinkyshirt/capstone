import 'package:flutter/material.dart';
import 'utils.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          textAlign: TextAlign.center,
          "Settings",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: ListView(
            children: [
              Section(
                children: [
                  Multicard(
                      mode: MulticardMode.primary,
                      tiles: [
                        ListTile(
                          title: const Text("Account"),
                          leading: const Icon(Icons.person),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            // Navigate to account settings
                          },
                        ),
                      ]
                  ),
                ],
              ),
              Section(
                title: "General",
                children: [
                  Multicard(
                      mode: MulticardMode.secondary,
                      tiles: [
                        ListTile(
                          title: const Text("Dark theme"),
                          trailing: Switch(value: false, onChanged: (_) {}),
                        ),
                      ]
                  ),
                ],
              ),

              const Section(
                children: [
                  Multicard(
                      mode: MulticardMode.primary,
                      tiles: [
                        ListTile(
                          title: Text("Account"),
                          leading: Icon(Icons.privacy_tip),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        ListTile(
                          title: Text("Notification preferences"),
                          leading: Icon(Icons.music_note),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        ListTile(
                          title: Text("Appearance settings"),
                          leading: Icon(Icons.nights_stay),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        ListTile(
                          title: Text("Advanced settings"),
                          leading: Icon(Icons.computer_outlined),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ]
                  ),
                ],
              ),

              const Section(
                children: [
                  Multicard(
                    mode: MulticardMode.primary,
                    tiles: [
                      ListTile(
                        title: Text("Help & support"),
                        leading: Icon(Icons.question_mark),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      ListTile(
                        title: Text("Sign out"),
                        leading: Icon(Icons.sign_language_outlined),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ],
              ),

              Section(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Go back"),
                      onPressed: () {
                        // Go back
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}