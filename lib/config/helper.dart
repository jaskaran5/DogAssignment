import 'dart:developer';
import 'package:assignment_dog/core/helpers/all_getter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void exit() {
  SystemNavigator.pop();
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double safeAreaHeight(BuildContext context) {
  return (MediaQuery.of(context).padding.top) /*+
          MediaQuery.of(context).padding.bottom)*/ +
      15;
}

void unFocus() {
  if (FocusManager.instance.primaryFocus?.hasFocus == true) {
    FocusScope.of(Getters.getContext!).unfocus();
  }
}

SizedBox yHeight(double height) {
  return SizedBox(height: height);
}

SizedBox xWidth(double width) {
  return SizedBox(width: width);
}

void pushTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void pushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void pushReplacementNamed(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

void pushRemoveUtil(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) {
      return false;
    },
  );
}

void offAllNamed(BuildContext context, String routesName) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    routesName,
    (Route<dynamic> route) => false,
  );
}

void toNamed(BuildContext context, String routesName, {Object? args}) {
  Navigator.pushNamed(context, routesName, arguments: args);
}

void back(BuildContext context) {
  Navigator.pop(context);
}

void printLog(dynamic msg, {String fun = ""}) {
  _printLog(' $fun=> ${msg.toString()}');
}

void functionLog({required dynamic msg, required dynamic fun}) {
  _printLog("${fun.toString()} ::==> ${msg.toString()}");
}

void _printLog(dynamic msg, {String name = "Riverpod"}) {
  if (kDebugMode) {
    log(msg.toString(), name: name);
  }
}

void blocLog({required String msg, required String bloc}) {
  _printLog("${bloc.toString()} ::==> ${msg.toString()}");
}

void showSnackBar({String? message, bool isError = true}) {
  if (message == null || message.isEmpty == true) return;
  final conetxt = Getters.getContext!;
  ScaffoldMessenger.of(conetxt).clearSnackBars();

  ScaffoldMessenger.of(conetxt).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
