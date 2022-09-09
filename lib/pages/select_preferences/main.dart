import 'package:flutter/material.dart';
import './preferences_selection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool didClickCurrency = false;
  bool remove = false;
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    void refresh() {
      setState(() {
        print('clicked');
        print(didClickCurrency);
        didClickCurrency = !didClickCurrency;
        offset -= const Offset(2, 0);
      });
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Please select the following:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(
                  height: 70,
                ),
                // !didClickCurrency
                //     ? PreferencesSelection(notifyParent: refresh)
                //     : Container(),
                AnimatedSlide(
                  offset: offset,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: !remove
                      ? PreferencesSelection(notifyParent: refresh)
                      : Container(),
                ),
              ],
            ),
          ),
        ));
  }
}
