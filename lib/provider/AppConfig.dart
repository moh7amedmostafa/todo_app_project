import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_todo/firebase_utils.dart';

import '../model/add_task.dart';

class AppConfig extends ChangeNotifier {
  String Language = 'en';
  ThemeMode themes = ThemeMode.light;
  bool isDone = false;
  List<Task> taskList = [];
  DateTime selectedDay = DateTime.now();

  void appLanguage(String NewLanguage) {
    if (Language == NewLanguage) {
      return;
    }
    Language = NewLanguage;
    notifyListeners();
  }

  void ChangeTheme(ThemeMode NewTheme) {
    if (themes == NewTheme) {
      return;
    }
    themes = NewTheme;
    notifyListeners();
  }

  void isDonee(bool isTrue) {
    if (isDone == isTrue) {
      return;
    }
    isDone = isTrue;
    notifyListeners();
  }

  Future<void> getAllTask() async {
    QuerySnapshot<Task> querySnapshot =
        await getTaskFromFirebase().orderBy('date').get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((task) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(task.date);
      if (selectedDay.day == dateTime.day &&
          selectedDay.month == dateTime.month &&
          selectedDay.year == dateTime.year) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate) {
    selectedDay = newDate;
    notifyListeners();
  }

  void EditeIsDone(Task task) {
    doneTaskfromFireBas(task);
  }

  void EditeTask(Task task) {
    editeTaskInFireBase(task);
  }
}
