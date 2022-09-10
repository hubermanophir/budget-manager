import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final PageController pageController;
  final int index;
  const WelcomePage(
      {super.key, required this.pageController, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              "Welcome!",
              style: TextStyle(fontSize: 30),
            )),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    pageController.animateToPage(index + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: const Text('Get Started')),
            )
          ],
        ),
      ),
    );
  }
}
