import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_todo/Home_Screen/task_list/Task_Screen.dart';
import 'package:test_todo/Home_Screen/task_list/Task_Sheet.dart';

import '../Settings_Screen/Settings_Screen.dart';
import '../mytheme.dart';

class Home_Screen extends StatefulWidget {
  static const String routeName = 'Home_screen';

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todolist),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskSheet();
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: MyThemes.whiteColor, width: 5),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 0,
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selected,
          onTap: (index) {
            selected = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: AppLocalizations.of(context)!.todolist),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings),
          ],
        ),
      ),
      body: tabs[selected],
    );
  }

  List<Widget> tabs = [Task_Screen(), Setting_Screen()];

  void showTaskSheet() {
    showModalBottomSheet(context: context, builder: (context) => Task_Sheet());
  }
}
