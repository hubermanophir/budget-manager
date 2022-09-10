import 'package:flutter/material.dart';

class BudgetSelect extends StatefulWidget {
  int index;
  final PageController pageController;
  BudgetSelect({
    super.key,
    required this.pageController,
    required this.index,
  });

  @override
  State<BudgetSelect> createState() => _BudgetSelectState();
}

class _BudgetSelectState extends State<BudgetSelect> {
  var budget = '0';
  void changeBudget(String value) {
    setState(() {
      budget = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'My monthly budget is: ${budget != '' ? budget : '0'}',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
          child: TextField(
            onChanged: ((value) {
              changeBudget(value);
            }),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  widget.pageController.animateToPage(widget.index + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text('Done')))
      ],
    )));
  }
}
