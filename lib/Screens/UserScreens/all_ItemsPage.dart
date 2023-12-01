import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/Screens/UserScreens/single_ItemPage.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../SharedWidgets/brand_AllItemDetails.dart';
import '../../SharedWidgets/user_AllItemImageContainer.dart';
import '../../constants.dart';

class AllItemsPage extends StatelessWidget {
  AllItemsPage(
      {super.key, required this.selectedCategory, required this.collection});
  String selectedCategory;
  String collection;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EcommerceProvider>(context);
    return Scaffold(
      appBar: sharedAppBar(context, title: (selectedCategory.toUpperCase())),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: provider.firestore
                    .collection(collection)
                    .doc(selectedCategory)
                    .collection(selectedCategory)
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var snap = snapshot.data?.docs.toList()[index];
                            return sharedCircularPadding(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingleItemPage(
                                          selectedBrandCategory:
                                              selectedCategory,
                                          collection: collection,
                                          snap: snap,
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    blackColor.withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurStyle: BlurStyle.solid,
                                                offset: const Offset(5, 5),
                                                blurRadius: 11)
                                          ],
                                          color: whiteColor),
                                      child: index % 2 == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: sharedPadding(
                                                    padding: 5,
                                                    child: BrandAllItemDetails(
                                                        category:
                                                            selectedCategory,
                                                        snap: snap),
                                                  ),
                                                ),
                                                UserAllItemContainer(
                                                    snap: snap),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                UserAllItemContainer(
                                                    snap: snap),
                                                Expanded(
                                                  child: sharedPadding(
                                                    padding: 5,
                                                    child: BrandAllItemDetails(
                                                        category:
                                                            selectedCategory,
                                                        snap: snap),
                                                  ),
                                                ),
                                              ],
                                            )),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
