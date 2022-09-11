import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'currency_selection_page.dart';
import './welcome_page.dart';
import './budget_selection_page.dart';
import './reset_date_selection_page.dart';
import './summary_page.dart';

class SelectPreferences extends StatefulWidget {
  const SelectPreferences({Key? key}) : super(key: key);

  @override
  State<SelectPreferences> createState() => _SelectPreferences();
}

class _SelectPreferences extends State<SelectPreferences> {
  // declare and initizlize the page controller
  final PageController _pageController = PageController(initialPage: 0);
  String _budget = '0';
  // the index of the current page
  int _activePage = 0;
  IconData selectedCurrency = FontAwesomeIcons.shekelSign;
  int _dayOfMonthForReset = 1;
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

  void changeBudget(String value) {
    setState(() {
      _budget = value;
    });
  }

  void changeDayOfMonth(int day) {
    setState(() {
      _dayOfMonthForReset = day;
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
          changeBudget: changeBudget,
          budget: _budget),
      ResetDateSelector(
        dayOfMonthForReset: _dayOfMonthForReset,
        changeDayOfMonth: changeDayOfMonth,
        index: 3,
        pageController: _pageController,
      ),
      SummaryPage(
          dayOfMonthForReset: _dayOfMonthForReset,
          budget: _budget,
          selectedCurrency: selectedCurrency)
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
                                  duration: const Duration(milliseconds: 180),
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
