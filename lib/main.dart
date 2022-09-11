import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/select_preferences/main.dart';
import './pages/main_dashboard/main.dart';
import './models/payment_model.dart';
import './models/payments_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  // Payment payment = new Payment(
  //     name: 'toyota',
  //     amount: 200.00,
  //     creationDate: DateTime.now(),
  //     category: 'cars');
  // await DatabaseConnect().insertPayment(payment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: true ? DashboardPage() : Column(),
    );
  }
}
