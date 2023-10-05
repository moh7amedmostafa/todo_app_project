import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/firebase_utils.dart';
import 'package:test_todo/model/add_task.dart';
import 'package:test_todo/provider/AppConfig.dart';

class Task_Sheet extends StatefulWidget {
  @override
  State<Task_Sheet> createState() => _Task_SheetState();
}

class _Task_SheetState extends State<Task_Sheet> {
  var formKey = GlobalKey<FormState>();

  String title = '';

  String description = '';
  DateTime selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return Container(
        margin: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.add,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Please add Title";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          title = text;
                        },
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.title)),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "please add your task";
                        }
                      },
                      onChanged: (text) {
                        description = text;
                      },
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.task),
                      maxLines: 4,
                      minLines: 4,
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.select_time,
              style: provider.themes == ThemeMode.light
                  ? Theme.of(context).textTheme.headline4
                  : Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                chooseDate();
              },
              child: Text(
                "${selectDate.month}/${selectDate.day}/${selectDate.year}",
                style: provider.themes == ThemeMode.light
                    ? Theme.of(context).textTheme.headline4
                    : Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                addTaskButton();
              },
              child: Text(AppLocalizations.of(context)!.save,
                  style: Theme.of(context).textTheme.headline1),
            )
          ],
        ));
  }

  void chooseDate() async {
    var selectTime = await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectTime != null) {
      selectDate = selectTime;
      setState(() {});
    }
  }

  void addTaskButton() {
    if (formKey.currentState?.validate() == true) {}
    Task task = Task(
        title: title,
        description: description,
        date: selectDate.millisecondsSinceEpoch);
    addTaskFireStore(task).timeout(Duration(milliseconds: 500), onTimeout: () {
      print('done');
      Navigator.pop(context);
    });
  }
}
