import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/Screens/UserScreens/profile_Page.dart';
import 'package:ecommerce/Screens/UserScreens/single_ItemPage.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../SharedWidgets/product_ListView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'shoes';
  String brandCategory = 'adidas';
  String searchQuery = '';
  late FocusNode focusNode;
  @override
  void initState() {
    Provider.of<EcommerceProvider>(context, listen: false).getUserDetails();
    Provider.of<EcommerceProvider>(context, listen: false).getUserCategory();
    Provider.of<EcommerceProvider>(context, listen: false).getBrandCategory();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EcommerceProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: sharedPadding(
            padding: 15,
            child: Column(
              children: [
                //First  Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover',
                      style: nameTextStyle.copyWith(fontSize: 32),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ));
                        },
                        child: CircleAvatar(
                          backgroundColor: brandColor,
                          child:
                              Icon(Icons.person, color: whiteColor, size: 38),
                        )),
                  ],
                ),
                SizedBoxTen,

                //Search Text Field
                TextField(
                  focusNode: focusNode,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (a) {
                    setState(() {
                      searchQuery = a;
                    });
                  },
                  onSubmitted: (a) {
                    setState(() {
                      searchQuery = '';
                    });
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Search your favourite Item...........',
                    prefixIcon: const Icon(Icons.search_sharp),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
                if (focusNode.hasFocus) SearchBox(),
                //Categories
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.userCategory.length,
                    itemBuilder: (context, index) {
                      return sharedCircularPadding(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory =
                                  provider.userCategory[index].toLowerCase();
                            });
                          },
                          child: Text(
                            provider.userCategory[index].toUpperCase(),
                            style: nameTextStyle.copyWith(
                                color: blackColor.withOpacity(0.5)),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //Categories Items inside Container
                ProductListView(
                  provider: provider,
                  selectedBrandCategory: selectedCategory,
                  collection: 'categories',
                ),
                SizedBoxTen,
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.brandCategory.length,
                    itemBuilder: (context, index) {
                      return sharedCircularPadding(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              brandCategory =
                                  provider.brandCategory[index].toLowerCase();
                            });
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'assets/images/${provider.brandCategory[index].toString().toLowerCase()}.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ProductListView(
                  provider: provider,
                  selectedBrandCategory: brandCategory,
                  collection: 'brands',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding SearchBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: backgroundColor),
        height: 210,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('allitems').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.docs
                        .where((element) => element['name']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                        .length,
                    itemBuilder: (context, index) {
                      var snap = snapshot.data.docs
                          .where((element) => element['name']
                              .toString()
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .toList()[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleItemPage(
                                      snap: snap,
                                      collection: 'categories',
                                      selectedBrandCategory: snap['category']
                                          .toString()
                                          .toLowerCase()),
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: brandColor,
                                ),
                                height: 100,
                                width: 70,
                                child: Image.network(
                                  snap['image'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                child: sharedPadding(
                                  padding: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snap['name'],
                                        style: nameTextStyle,
                                      ),
                                      Text(
                                        'Nrs.${snap['price']}',
                                        style: priceTextStyle,
                                      ),
                                      Text(
                                        'From: ${snap['shopname']}',
                                        style: priceTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
