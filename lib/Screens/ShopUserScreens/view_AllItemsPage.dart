import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllItems extends StatelessWidget {
  int index;
  String category;
  ViewAllItems({super.key, required this.index, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, title: category),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildStreamBuilder(Provider.of<EcommerceProvider>(context),
                  index: index, scrollDirection: Axis.vertical),
            ),
          ],
        ),
      ),
    );
  }
}
