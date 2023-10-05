import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/Home_Screen/task_list/Item_Task.dart';
import 'package:test_todo/provider/AppConfig.dart';

class Task_Screen extends StatefulWidget {
  @override
  State<Task_Screen> createState() => _Task_ScreenState();
}

class _Task_ScreenState extends State<Task_Screen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    provider.getAllTask();
    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectedDay,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            provider.changeSelectedDate(date);
          },
          leftMargin: 20,
          monthColor: Colors.black87,
          dayColor: Colors.teal[500],
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.redAccent[100],
          dotsColor: Color(0xFF333A47),
          locale: 'en_ISO',
        ),
        SizedBox(
          height: 9,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Item_Task(task: provider.taskList[index]);
              },
              itemCount: provider.taskList.length),
        )
      ],
    );
  }
}
