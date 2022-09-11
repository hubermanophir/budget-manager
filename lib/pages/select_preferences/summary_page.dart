import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  final String budget;
  final int dayOfMonthForReset;
  final IconData selectedCurrency;

  const SummaryPage(
      {super.key,
      required this.budget,
      required this.dayOfMonthForReset,
      required this.selectedCurrency});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Youre budget is ${widget.budget}')),
          Center(
              child: Text('Youre reset date is ${widget.dayOfMonthForReset}')),
          Center(child: Icon(widget.selectedCurrency))
        ],
      )),
    );
  }
}
