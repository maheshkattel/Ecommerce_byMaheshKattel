import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Provider/provider.dart';
import '../constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

//Material Button used in authentication and Adding Items
MaterialButton sharedButton({
  required String text,
  required Function() onTap,
}) {
  return MaterialButton(
    onPressed: onTap,
    color: brandColor,
    child: Text(text, style: nameTextStyle.copyWith(color: whiteColor)),
  );
}

//Container used inside Drawer
Container sharedDrawerContainer(
    {required String text, required Function() onTap}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: whiteColor.withOpacity(0.1),
            offset: const Offset(5, 5),
            blurRadius: 20,
            spreadRadius: 1)
      ],
      borderRadius: BorderRadius.circular(7),
    ),
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: Text(
        text,
        style: nameTextStyle.copyWith(
            fontWeight: FontWeight.w600, color: whiteColor),
      ),
    ),
  );
}

//Shared App Bar
AppBar sharedAppBar(BuildContext context, {required String title}) {
  return AppBar(
      title: Text(
        title,
        style: categoryTextStyle.copyWith(color: whiteColor),
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: brandColor);
}

//Shared Shop Items for all items and single item Category
StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildStreamBuilder(
    EcommerceProvider provider,
    {required int index,
    required scrollDirection}) {
  return StreamBuilder(
    stream: _firestore
        .collection('shopdetails')
        .doc(_auth.currentUser!.uid)
        .collection('myitems')
        .where('category', isEqualTo: provider.shopCategory[index])
        .snapshots(),
    builder: (context, snapshot) {
      return snapshot.hasData
          ? ListView.builder(
              scrollDirection: scrollDirection,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data?.docs.toList()[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data?['image']),
                                  fit: BoxFit.cover),
                              color: whiteColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          height: 190,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            data?['name'],
                            style: nameTextStyle,
                          ),
                        ),
                        SizedBoxFive,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Text("NRs. ${data!['price']}",
                                  style: priceTextStyle),
                              const Spacer(),
                              InkWell(
                                child: Icon(
                                  Icons.edit,
                                  color: brandColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBoxFive
                      ],
                    ),
                  ),
                );
              },
            )
          : Container();
    },
  );
}
