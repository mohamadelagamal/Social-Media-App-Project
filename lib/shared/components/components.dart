import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_application/modules/login/login_screen.dart';
import 'package:social_media_application/shared/network/local/cache_helper.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 10.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));

Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? submit,
  Function(String)? change,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
  required BuildContext context,
  int? maxLines=1,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      onFieldSubmitted: submit,
      maxLines: maxLines,
      onChanged: change,
      style: Theme.of(context).textTheme.bodyText2, // Add this line
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyText2, // Add this line
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        ),
      ),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// show Flutter toast
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
void signOut({required context}) {
  // sign out
  CacheHelper.removeData(key: 'token').then((value) => {
        if (value) {navigateAndFinish(context, SocialLoginScreen())}
      });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  List<Widget> actions = const <Widget>[],
}) =>
    AppBar(
      title: Text('$title'),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      actions: actions,
      titleSpacing: 0.0,
    );
Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(),style: TextStyle(color: Colors.blue),),
    );
