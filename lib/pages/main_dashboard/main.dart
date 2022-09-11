import 'package:flutter/material.dart';
import '../../models/payment_model.dart';
import '../../models/payments_database.dart';

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
    // TODO: implement initState
    super.initState();
    refreshPayments();
  }

  void refreshPayments() async {
    setState(() => {isLoading = true});
    payments = await DatabaseConnect().getAllPayments();
    setState(() => {isLoading = true});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            // refreshPayments();
            print(payments);
          },
          child: Text('test')),
    );
  }
}
