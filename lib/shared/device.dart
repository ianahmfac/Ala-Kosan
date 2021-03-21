import 'package:flutter/material.dart';

double heightOfDevice(BuildContext context) =>
    MediaQuery.of(context).size.height;
double widthOfDevice(BuildContext context) => MediaQuery.of(context).size.width;
EdgeInsets paddingSafeDevice(BuildContext context) =>
    MediaQuery.of(context).padding;
