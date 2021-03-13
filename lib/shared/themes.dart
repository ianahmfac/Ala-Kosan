import 'package:flutter/material.dart';

const Color primaryColor = Colors.redAccent;
const Color accentColor = Colors.orange;

ElevatedButtonThemeData elevatedButtonStyle = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
      primary: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
);

OutlinedButtonThemeData outlineButtonStyle = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    side: BorderSide(
      color: primaryColor,
      width: 1,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

TextStyle onBoardTitle(BuildContext context) =>
    Theme.of(context).textTheme.headline5;
TextStyle onBoardSubtitle(BuildContext context) =>
    Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey);
TextStyle contentBody(BuildContext context) =>
    Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16);
TextStyle contentTitle2(BuildContext context) =>
    Theme.of(context).textTheme.headline4.copyWith(color: Colors.black);
TextStyle contentTitle(BuildContext context) =>
    Theme.of(context).textTheme.headline6;
TextStyle buttonText(BuildContext context) =>
    Theme.of(context).textTheme.button;

ScaffoldFeatureController showSnackbarError(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
