import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ResetDateSelector extends StatefulWidget {
  final int dayOfMonthForReset;
  final Function changeDayOfMonth;
  final int index;
  final PageController pageController;
  const ResetDateSelector(
      {super.key,
      required this.dayOfMonthForReset,
      required this.changeDayOfMonth,
      required this.index,
      required this.pageController});

  @override
  State<ResetDateSelector> createState() => _ResetDateSelectorState();
}

class _ResetDateSelectorState extends State<ResetDateSelector> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Select day of reset')),
            NumberPicker(
              value: widget.dayOfMonthForReset,
              minValue: 1,
              maxValue: 28,
              onChanged: (value) => widget.changeDayOfMonth(value),
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
        ),
      ),
    );
  }
}
