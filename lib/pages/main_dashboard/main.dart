import 'package:flutter/material.dart';
import '../../models/payment_model.dart';
import '../../models/payments_database.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Payment> payments;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshPayments();
  }

  void refreshPayments() async {
    setState(() => {isLoading = true});
    payments = await DatabaseConnect().getAllPayments();
    setState(() => {isLoading = false});
  }

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !isLoading && payments.isNotEmpty
              ? Center(child: CircularProgressIndicator())
              : Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
