import 'package:ecommerce/Screens/ShopUserScreens/view_AllItemsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/provider.dart';
import '../../SharedWidgets/shared_Methods.dart';
import '../../constants.dart';

class ItemsPage extends StatelessWidget {
  static String id = 'ItemsPage';
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EcommerceProvider>(context);
    return Scaffold(
      appBar: sharedAppBar(context, title: 'ALL ITEMS'),
      body: SafeArea(
        child: ListView.builder(
          itemCount: provider.shopCategory.length,
          itemBuilder: (context, int) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxTen,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(provider.shopCategory[int].toUpperCase(),
                          style: categoryTextStyle),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewAllItems(
                                        index: int,
                                        category: provider.shopCategory[int]
                                            .toUpperCase(),
                                      )));
                        },
                        child: Text('View All',
                            style: categoryTextStyle.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 19)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 278,
                    child: buildStreamBuilder(provider,
                        index: int, scrollDirection: Axis.horizontal))
              ],
            );
          },
        ),
      ),
    );
  }
}
