import 'package:flutter/material.dart';
import '../Provider/provider.dart';
import '../Screens/UserScreens/single_ItemPage.dart';
import '../Screens/UserScreens/all_ItemsPage.dart';
import '../constants.dart';

class ProductListView extends StatelessWidget {
  const ProductListView(
      {super.key,
      required this.provider,
      required this.selectedBrandCategory,
      required this.collection});

  final EcommerceProvider provider;
  final String selectedBrandCategory;
  final String collection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 290,
        child: Column(children: [
          SizedBox(
            height: 255,
            child: StreamBuilder(
              stream: provider.firestore
                  .collection(collection)
                  .doc(selectedBrandCategory)
                  .collection(selectedBrandCategory)
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
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
                                              snap: snap,
                                              collection: collection,
                                              selectedBrandCategory:
                                                  selectedBrandCategory),
                                        ));
                                  },
                                  child: Column(children: [
                                    Container(
                                        height: 234,
                                        width: 181,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: blackColor
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurStyle: BlurStyle.solid,
                                                  offset: const Offset(5, 5),
                                                  blurRadius: 11)
                                            ],
                                            color: whiteColor),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 174,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snap!['image']),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                  color: brandColor,
                                                ),
                                              ),
                                              sharedPadding(
                                                padding: 5,
                                                child: Text(
                                                  snap['name'],
                                                  style:
                                                      nameTextStyle.copyWith(),
                                                ),
                                              ),
                                              sharedPadding(
                                                  padding: 5,
                                                  verticalPadding: 5,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'NRs.${snap['price']}',
                                                            style:
                                                                priceTextStyle),
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => SingleItemPage(
                                                                        collection:
                                                                            collection,
                                                                        selectedBrandCategory:
                                                                            selectedBrandCategory,
                                                                        snap:
                                                                            snap),
                                                                  ));
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_circle_right,
                                                              color: brandColor,
                                                            ))
                                                      ]))
                                            ]))
                                  ])));
                        },
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBoxFive,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "View All",
              style: priceTextStyle.copyWith(
                  fontWeight: FontWeight.bold, color: brandColor),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllItemsPage(
                          selectedCategory: selectedBrandCategory,
                          collection: collection),
                    ));
              },
              child: Icon(
                Icons.arrow_forward_sharp,
                color: brandColor,
              ),
            )
          ])
        ]));
  }
}
