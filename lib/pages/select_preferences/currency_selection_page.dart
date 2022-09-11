import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Option {
  String id;
  IconData icon;
  Option(this.id, this.icon);
}

class CurrencySelection extends StatefulWidget {
  final PageController pageController;
  final Function setSelectedCurrencyIcon;
  int index;

  CurrencySelection(
      {super.key,
      required this.pageController,
      required this.index,
      required this.setSelectedCurrencyIcon});

  @override
  State<CurrencySelection> createState() => _CurrencySelectionState();
}

class _CurrencySelectionState extends State<CurrencySelection> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;

    List<Option> options = [
      Option('shekel', FontAwesomeIcons.shekelSign),
      Option('dollar', FontAwesomeIcons.dollarSign),
      Option('euro', FontAwesomeIcons.euroSign),
      Option('sterling', FontAwesomeIcons.sterlingSign)
    ];

    List<Widget> renderCurrencyOptions(List<Option> options) {
      return options
          .map(
            (option) =>
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[400],
                    onPrimary: Colors.white,
                  ),
                  onPressed: () async => {
                        prefs = await SharedPreferences.getInstance(),
                        await prefs.setString('currency', option.id),
                        widget.pageController.animateToPage(widget.index + 1,
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeIn),
                        widget.setSelectedCurrencyIcon(option.icon)
                      },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 100),
                    child: Icon(
                      option.icon,
                      size: 32,
                    ),
                  )),
              const SizedBox(
                height: 85,
              )
            ]),
          )
          .toList();
    }

    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose youre currency:',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 42,
          ),
          ...renderCurrencyOptions(options),
        ],
      )),
    ));
  }
}
