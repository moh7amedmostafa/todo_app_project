import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/mytheme.dart';
import 'package:test_todo/provider/AppConfig.dart';

class Language_Sheet extends StatefulWidget {
  @override
  _Language_SheetState createState() => _Language_SheetState();
}

class _Language_SheetState extends State<Language_Sheet> {
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
                provider.appLanguage('en');
              },
              child: provider.Language == 'en'
                  ? getSelected(AppLocalizations.of(context)!.englis)
                  : unSelected(AppLocalizations.of(context)!.englis)),
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                provider.appLanguage('ar');
              },
              child: provider.Language == 'ar'
                  ? getSelected(AppLocalizations.of(context)!.arabic)
                  : unSelected(AppLocalizations.of(context)!.arabic))
        ],
      ),
    );
  }

  Widget getSelected(String text) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.headline3),
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
