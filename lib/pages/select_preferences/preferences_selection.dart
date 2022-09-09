import 'package:flutter/material.dart';
import './main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Option {
  String id;
  IconData icon;
  Option(this.id, this.icon);
}

class ReferenceSelection {
  String sectionName;
  List<Option> options;
  ReferenceSelection(this.sectionName, this.options);
}

class PreferencesSelection extends StatelessWidget {
  final Function() notifyParent;
  const PreferencesSelection({super.key, required this.notifyParent});
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;

    ReferenceSelection preferencesSelection = ReferenceSelection('currency', [
      Option('shekel', FontAwesomeIcons.shekelSign),
      Option('dollar', FontAwesomeIcons.dollarSign),
      Option('euro', FontAwesomeIcons.euroSign),
      Option('sterling', FontAwesomeIcons.sterlingSign)
    ]);

    return Column(children: [
      Text(
        preferencesSelection.sectionName,
        style: TextStyle(fontSize: 22),
      ),
      const SizedBox(
        height: 45,
      ),
      ...preferencesSelection.options
          .map((option) => Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                        onPressed: () async => {
                              prefs = await SharedPreferences.getInstance(),
                              await prefs.setString('currency', option.id),
                              notifyParent()
                            },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 100),
                          child: Icon(
                            option.icon,
                            size: 32,
                          ),
                        ))
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ))
          .toList(),
    ]);
  }
}
