import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/model/add_task.dart';
import 'package:test_todo/mytheme.dart';
import 'package:test_todo/provider/AppConfig.dart';

class Edit_Task extends StatefulWidget {
  static const String routeName = 'Edit_Task';

  @override
  State<Edit_Task> createState() => _Edit_TaskState();
}

class _Edit_TaskState extends State<Edit_Task> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime selectDate = DateTime.now();
  late Task task;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      task = ModalRoute.of(context)?.settings.arguments as Task;
      titleController.text = task.title;
      descriptionController.text = task.description;
      selectDate = DateTime.fromMillisecondsSinceEpoch(task.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: MyThemes.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.edit,
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
                            controller: titleController,
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
                          controller: descriptionController,
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
                    if (formKey.currentState!.validate()) {
                      task.title = titleController.text;
                      task.description = descriptionController.text;
                      task.date = selectDate.millisecondsSinceEpoch;
                      provider.EditeTask(task);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.save,
                      style: Theme.of(context).textTheme.headline1),
                )
              ],
            )),
      ),
    );
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
}
