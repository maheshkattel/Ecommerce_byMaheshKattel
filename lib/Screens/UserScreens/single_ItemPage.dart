import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../SharedWidgets/product_ListView.dart';

List<String> size = ['M', 'S', 'L', '46', '50'];

class SingleItemPage extends StatefulWidget {
  const SingleItemPage(
      {super.key,
      required this.snap,
      required this.collection,
      required this.selectedBrandCategory});
  final snap;
  final String collection;
  final String selectedBrandCategory;

  @override
  State<SingleItemPage> createState() => _SingleItemPageState();
}

class _SingleItemPageState extends State<SingleItemPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Color sizeColor = backgroundColor;
  int quantity = 1;
  List<String> selectedSize = [];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EcommerceProvider>(context);
    return Scaffold(
      appBar: sharedAppBar(context, title: widget.snap['name']),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(25)),
                      image: DecorationImage(
                          image: NetworkImage(widget.snap['image']),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBoxTen,
              sharedPadding(
                padding: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(widget.snap['name'], style: nameTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('NRs. ${widget.snap['price']}',
                            style: priceTextStyle.copyWith(
                                fontWeight: FontWeight.bold)),
                        Text('from: ${widget.snap['shopname']}',
                            style: priceTextStyle.copyWith(
                                fontStyle: FontStyle.italic)),
                      ],
                    ),
                    SizedBoxFive,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Size:', style: categoryTextStyle),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: brandColor, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: sharedPadding(
                            padding: 7,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantity > 1 ? quantity-- : null;
                                    });
                                  },
                                  child: Icon(CupertinoIcons.minus_square_fill,
                                      color: brandColor),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  quantity.toString(),
                                  style: priceTextStyle.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        quantity < 9 ? quantity++ : null;
                                      });
                                    },
                                    child:
                                        Icon(Icons.add_box, color: brandColor)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBoxFive,
                    SizedBox(
                      height: 34,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.snap['size'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSize.contains(
                                            widget.snap['size'][index])
                                        ? selectedSize
                                            .remove(widget.snap['size'][index])
                                        : selectedSize
                                            .add(widget.snap['size'][index]);
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: selectedSize.contains(
                                                widget.snap['size'][index])
                                            ? brandColor
                                            : backgroundColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: brandColor, width: 2)),
                                    child: sharedPadding(
                                      padding: 5,
                                      child: Text(
                                        widget.snap['size'][index],
                                        style: priceTextStyle,
                                      ),
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBoxFive,
                    ReadMoreText(
                      '${widget.snap['description']}',
                      trimLines: 4,
                      textAlign: TextAlign.justify,
                      style: priceTextStyle,
                      colorClickableText: brandColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Show more',
                      trimExpandedText: ' show less',
                    ),
                    sharedButton(
                        text: 'Add to Cart',
                        onTap: () async {
                          selectedSize.isNotEmpty
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar('Item added to Cart'))
                              : null;
                          selectedSize.isNotEmpty
                              ? _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .collection('cart')
                                  .doc()
                                  .set(<String, dynamic>{
                                  'name': widget.snap['name'],
                                  'orderstatus': '',
                                  'quantity': quantity,
                                  'price': widget.snap['price'],
                                  'size': selectedSize,
                                  'shopname': widget.snap['shopname'],
                                  'image': widget.snap['image'],
                                })
                              : showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: const Text('Please Select Size'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Ok',
                                              style: priceTextStyle,
                                            ))
                                      ]),
                                );

                          setState(() {
                            quantity = 1;
                            selectedSize.clear();
                          });
                        }),
                    SizedBoxTen,
                    Text(
                      'Related Products:',
                      style: categoryTextStyle.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              sharedPadding(
                padding: 15,
                child: ProductListView(
                  provider: provider,
                  selectedBrandCategory: widget.selectedBrandCategory,
                  collection: widget.collection,
                ),
              ),
              SizedBoxTen,
            ],
          ),
        ),
      ),
    );
  }
}
