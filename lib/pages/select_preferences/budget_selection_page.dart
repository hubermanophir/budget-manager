import 'package:flutter/material.dart';

class BudgetSelect extends StatefulWidget {
  int index;
  String budget;
  final PageController pageController;
  final Function changeBudget;
  BudgetSelect(
      {super.key,
      required this.pageController,
      required this.index,
      required this.changeBudget,
      required this.budget});

  @override
  State<BudgetSelect> createState() => _BudgetSelectState();
}

class _BudgetSelectState extends State<BudgetSelect> {
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
            'My monthly budget is: ${widget.budget != '' ? widget.budget : '0'}',
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
          child: TextField(
            onChanged: ((value) {
              widget.changeBudget(value);
            }),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
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
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeIn);
                },
                child: const Text('Done')))
      ],
    )));
  }
}
