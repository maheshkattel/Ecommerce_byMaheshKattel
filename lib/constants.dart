import 'package:flutter/material.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
  prefixIcon: const Icon(Icons.email_sharp),
  hintText: 'Email Here............',
  hintStyle: TextStyle(color: blackColor),
  contentPadding: const EdgeInsets.all(3),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: blackColor),
    borderRadius: const BorderRadius.all(
      Radius.circular(3),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: blackColor),
    borderRadius: const BorderRadius.all(
      Radius.circular(3),
    ),
  ),
);
Color backgroundColor = Colors.grey.shade300;
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color brandColor = const Color(0xff013a95);
SizedBox SizedBoxTen = const SizedBox(height: 10);
SizedBox SizedBoxFive = const SizedBox(height: 5);

TextStyle nameTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: blackColor,
    overflow: TextOverflow.ellipsis);

TextStyle priceTextStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: blackColor,
    overflow: TextOverflow.ellipsis);

TextStyle categoryTextStyle = const TextStyle(
    fontSize: 27, fontFamily: 'Jaldi', fontWeight: FontWeight.w700);

Padding sharedPadding({
  required Widget child,
  required double padding,
  double? verticalPadding,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: padding, vertical: verticalPadding = 0),
    child: child,
  );
}

Padding sharedCircularPadding({required Widget child}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: child,
  );
}

ListTile sharedListTile(
    {required IconData icon,
    required String title,
    required Function() onTap}) {
  return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: brandColor,
      ),
      title: Text(
        title,
        style: nameTextStyle,
      ));
}

//Snackbar at Time of error

snackBar(String text) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    elevation: 3,
    shape: Border.all(color: whiteColor, width: 2),
    backgroundColor: brandColor,
    content: Text(
      text,
      style: priceTextStyle.copyWith(color: whiteColor, fontSize: 16),
    ),
    action: SnackBarAction(
      backgroundColor: whiteColor,
      textColor: blackColor,
      label: 'Okay',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
