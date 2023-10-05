import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/provider/AppConfig.dart';

import 'Home_Screen/home.dart';
import 'Home_Screen/task_list/Edit_Task.dart';
import 'mytheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork(); //offline
  runApp(
      ChangeNotifierProvider(create: (context) => AppConfig(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home_Screen.routeName,
      routes: {
        Home_Screen.routeName: (context) => Home_Screen(),
        Edit_Task.routeName: (context) => Edit_Task()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.Language),
      theme: MyThemes.LightTheme,
      darkTheme: MyThemes.DarkTheme,
      themeMode: provider.themes,
    );
  }
}
