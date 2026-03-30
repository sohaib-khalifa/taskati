import 'package:flutter/material.dart';

void pushReplacement(BuildContext context, Widget newScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => newScreen),
  );
}

Future<void>  pushTo(BuildContext context, Widget newScreen) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newScreen));
}

void popFrom(BuildContext context) {
  Navigator.pop(context);
}

void pushAndRemoveUntilAll(
  BuildContext context,
  Widget newScreen, {
  bool keepExistingRoutes = false,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => newScreen),
    (route) => keepExistingRoutes,
  );
}
