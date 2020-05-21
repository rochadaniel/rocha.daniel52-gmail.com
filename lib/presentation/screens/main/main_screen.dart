import 'package:covid19app/presentation/screens/main/pages/home_page.dart';
import 'package:covid19app/presentation/screens/main/pages/search_page.dart';
import 'package:covid19app/presentation/screens/main/pages/world_page.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'main_controller.dart';

/// References
/// Save Page state: https://stackoverflow.com/a/55512883
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [HomePage(), WorldPage(), SearchPage()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19"),
        backgroundColor: Constants.backgroundColor,
      ),
      body: Container(
        color: Constants.foregroundColor,
        child: GetBuilder<MainController>(
            init: MainController(
              getCountriesCoronaDetailsUseCase: Get.find(),
              getSavedCountryNameUseCase: Get.find(),
              saveCountryNameUseCase: Get.find(),
              getWorldCoronaDetailsUseCase: Get.find()
            ),
            initState: (_) {
              print("[main_screen] MainController initState");
              MainController.to.load();
            },
            builder: (_) {
              print("[main_screen] MainController Builder");
              return IndexedStack(
                children: _pages,
                index: _selectedIndex,
              );
            }),
      ),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        backgroundColor: Constants.backgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        items: [
          BottomNavigationBarItem(
              icon: Icon(LineIcons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.globe), title: Text('World')),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.search), title: Text('Search')),
        ],
      );
}
