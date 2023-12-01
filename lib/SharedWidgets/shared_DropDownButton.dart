import 'package:flutter/material.dart';
import '../constants.dart';

class SharedDropDownButton extends StatefulWidget {
  List<String> itemList;
  String faceItem;
  SharedDropDownButton(
      {super.key, required this.faceItem, required this.itemList});

  @override
  State<SharedDropDownButton> createState() => _SharedDropDownButtonState();
}

class _SharedDropDownButtonState extends State<SharedDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.faceItem,
      style: TextStyle(fontSize: 21, color: blackColor),
      items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          widget.faceItem = value!;
        });
      },
    );
  }
}
