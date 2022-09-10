import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'currency_selection_page.dart';
import './welcome_page.dart';
import './budget_selection_page.dart';
import './reset_date_selection_page.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStarted();
}

class _GettingStarted extends State<GettingStarted> {
  // declare and initizlize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // the index of the current page
  int _activePage = 0;
  IconData selectedCurrency = FontAwesomeIcons.shekelSign;

  // this list holds all the pages
  // all of them are constructed in the very end of this file for readability

  void nextPage() {
    setState(() {
      _activePage += 1;
    });
  }

  void setSelectedCurrencyIcon(IconData icon) {
    setState(() {
      selectedCurrency = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      WelcomePage(
        index: 0,
        pageController: _pageController,
      ),
      CurrencySelection(
          index: 1,
          pageController: _pageController,
          setSelectedCurrencyIcon: setSelectedCurrencyIcon),
      BudgetSelect(
        index: 2,
        pageController: _pageController,
      ),
      ResetDateSelector()
    ];
    return Scaffold(
      body: Stack(
        children: [
          // the page view
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
          // Display the dots indicator
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    _pages.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 8,
                              // check if a dot is connected to the current page
                              // if true, give it a different color
                              backgroundColor: _activePage == index
                                  ? Colors.blue[400]
                                  : Colors.grey,
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
