import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/provider/AppConfig.dart';

import '../mytheme.dart';

class Theme_Sheet extends StatefulWidget {
  @override
  State<Theme_Sheet> createState() => _Theme_SheetState();
}

class _Theme_SheetState extends State<Theme_Sheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                provider.ChangeTheme(ThemeMode.light);
              },
              child: provider.themes == ThemeMode.light
                  ? getSelected(
                      AppLocalizations.of(context)!.light,
                    )
                  : unSelected(
                      AppLocalizations.of(context)!.light,
                    )),
          SizedBox(height: 15),
          InkWell(
              onTap: () {
                provider.ChangeTheme(ThemeMode.dark);
              },
              child: provider.themes == ThemeMode.dark
                  ? getSelected(
                      AppLocalizations.of(context)!.dark,
                    )
                  : unSelected(
                      AppLocalizations.of(context)!.dark,
                    ))
        ],
      ),
    );
  }

  Widget getSelected(String text) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.headline3),
        SizedBox(width: 15),
        Icon(
          Icons.check,
          size: 25,
          color: MyThemes.greenColor,
        )
      ],
    );
  }

  Widget unSelected(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
