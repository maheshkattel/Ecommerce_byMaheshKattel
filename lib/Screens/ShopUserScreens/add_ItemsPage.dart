import 'dart:io';
import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../SharedWidgets/shared_Methods.dart';
import '../../SharedWidgets/shop_Drawer.dart';
import '../../databaseHelper/upload_ToStorage.dart';

List<String> categoryList = [
  'Shoes',
  'T-Shirts',
  'Pants',
  'Shocks',
  'Undergarments',
  'Belts'
];
List<String> sexList = ['Men', 'Women', 'Child', 'Unisex'];
List<String> brandList = [
  'No Brand',
  'Adidas',
  'Nike',
  'Puma',
  '361',
  'Sketchers',
  'New Balance'
];
List<String> selectedSize = [];
List<String> sizeList = [
  'Small',
  'Medium',
  'Large',
  'XL',
  'XXL',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
  '45',
  '46',
  '47',
  '48',
];

class AddItemsPage extends StatefulWidget {
  static String id = 'AddItemsPage';
  const AddItemsPage({super.key});

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  String categoryItem = categoryList.first;
  String sex = sexList.first;
  var sizeItem = sizeList.first;
  String brandItem = brandList.first;
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemPrice = TextEditingController();
  final TextEditingController _itemDescription = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? image;

  @override
  void dispose() {
    _itemName.dispose();
    _itemPrice.dispose();
    _itemDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: brandColor,
          foregroundColor: whiteColor,
          title: Text(
            Provider.of<EcommerceProvider>(context).shopName,
            style: categoryTextStyle,
          ),
          centerTitle: true),
      drawer: const ShopDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxTen,
                const Text(
                  'Please Select a Category',
                  style: TextStyle(fontSize: 19),
                ),
                Center(
                  child: DropdownButton(
                    value: categoryItem,
                    style: TextStyle(fontSize: 21, color: blackColor),
                    items: categoryList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        categoryItem = value!;
                      });
                    },
                  ),
                ),
                SizedBoxTen,
                TextField(
                  controller: _itemName,
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.add_business),
                      hintText: 'Name of an Item .....'),
                ),
                SizedBoxTen,
                TextField(
                  controller: _itemPrice,
                  keyboardType: TextInputType.number,
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.monetization_on_sharp),
                      hintText: 'Price of an Item .....'),
                ),
                SizedBoxTen,
                TextField(
                  controller: _itemDescription,
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.description_sharp),
                      hintText: 'Short Description of an Item ......'),
                ),
                SizedBoxTen,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        try {
                          XFile? pickedImage = await _imagePicker.pickImage(
                              source: ImageSource.gallery);
                          image = File(pickedImage!.path);
                          setState(() {});
                        } catch (e) {
                          if (kDebugMode) {
                            print(e.toString());
                          }
                        }
                      },
                      child: CircleAvatar(
                          radius: 36,
                          backgroundColor: blackColor.withOpacity(0.6),
                          foregroundColor: whiteColor,
                          child: image == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Add'),
                                    Text('image'),
                                  ],
                                )
                              : Image.file(image!)),
                    ),
                    Text(
                      'For:',
                      style: priceTextStyle,
                    ),
                    DropdownButton(
                      value: sex,
                      style: TextStyle(fontSize: 21, color: blackColor),
                      items:
                          sexList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          sex = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBoxTen,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Size:',
                      style: priceTextStyle,
                    ),
                    DropdownButton(
                      value: sizeItem,
                      style: TextStyle(fontSize: 21, color: blackColor),
                      items: sizeList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          sizeItem = value!;
                          selectedSize.add(value);
                        });
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedSize.clear();
                        });
                      },
                      child: Text(
                        'Clear',
                        style: priceTextStyle,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedSize.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: sharedCircularPadding(
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: brandColor),
                            ),
                            child: sharedPadding(
                              padding: 5,
                              child: Text(
                                selectedSize[index],
                                style: priceTextStyle,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBoxTen,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Brand:',
                      style: priceTextStyle,
                    ),
                    DropdownButton(
                      value: brandItem,
                      style: TextStyle(fontSize: 21, color: blackColor),
                      items: brandList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          brandItem = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBoxTen,
                Center(
                  child: sharedButton(
                    text: 'Add Items',
                    onTap: () {
                      UploadtoStorage(image: image!).addItems(
                          brandName: brandItem,
                          size: selectedSize,
                          image: image!,
                          name: _itemName.text.trim(),
                          price: int.parse(_itemPrice.text.trim()),
                          sex: sex,
                          category: categoryItem,
                          description: _itemDescription.text.trim());
                      _itemName.clear();
                      _itemPrice.clear();
                      _itemDescription.clear();
                      image = null;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
