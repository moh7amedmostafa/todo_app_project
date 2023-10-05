import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/Settings_Screen/Language_Sheet.dart';
import 'package:test_todo/Settings_Screen/Theme_Sheet.dart';
import 'package:test_todo/mytheme.dart';
import 'package:test_todo/provider/AppConfig.dart';

class Setting_Screen extends StatefulWidget {
  @override
  _Setting_ScreenState createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyThemes.whiteColor),
            child: InkWell(
              onTap: () {
                showBottomLanguage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.Language == 'ar'
                        ? AppLocalizations.of(context)!.arabic
                        : AppLocalizations.of(context)!.englis,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyThemes.whiteColor),
            child: InkWell(
              onTap: () {
                showBottomTheme();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      provider.themes == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: Theme.of(context).textTheme.headline2),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showBottomLanguage() {
    showModalBottomSheet(
        context: context, builder: (context) => Language_Sheet());
  }

  void showBottomTheme() {
    showModalBottomSheet(context: context, builder: (context) => Theme_Sheet());
  }
}
