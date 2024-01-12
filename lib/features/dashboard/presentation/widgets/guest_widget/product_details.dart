import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class ProductDetails extends ConsumerWidget {
  Map<String, dynamic> data;
  bool productAvailable;
  String collectionName;

  ProductDetails(
      {super.key,
      required this.data,
      required this.collectionName,
      required this.productAvailable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        productAvailable
            ? buildTitle(context)
            : const Center(
                child: SizedBox(
                    height: 50, child: Text("No product purchased....!")),
              )
      ],
    );
  }

  buildTitle(BuildContext context) {
    final productData = data['preferred_products'];

    List<Map<String, dynamic>> drinks = [];
    List<Map<String, dynamic>> smokes = [];

    for (final value in productData) {
      if (value['product_type'] == 'drink') {
        drinks.add(value);
      }
      if (value['product_type'] == 'smoke') {
        smokes.add(value);
      }
    }

    return Column(
      children: [
        productLists(smokes, "smoke", context),
        productLists(drinks, "drink", context),
      ],
    );
  }

  productLists(
      List<Map<String, dynamic>> listData, String type, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              type == "smoke" ? "Preferred Smokes" : "Preferred Drinks",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFFFFF)),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          // isAvailable == true
          // arrar.isNotEmpty
          // vall.isNotEmpty

          listData.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          // width: 150,
                          width: MediaQuery.of(context).size.width * 0.381,
                          child: const Text(
                            // "Attendee's Name",
                            'Category',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          // width: 125,
                          width: MediaQuery.of(context).size.width * 0.319,
                          child: const Text(
                            // "Attendee's Name",
                            'Brand',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ]),
                )
              : const Center(
                  child: SizedBox(
                      height: 30,
                      child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("No Preferences"))),
                ),
          const SizedBox(
            height: 6,
          ),
          ListView.builder(
              // itemCount: productData.length,
              itemCount: listData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int i) {
                // final productDataArray = productData[i];

                final productDataArray = listData[i];

                // if (productDataArray['product_type'] == type) {
                //   if (productDataArray.isEmpty) {
                //     return const Center(
                //       child:
                //           SizedBox(height: 50, child: Text("No Preferences")),
                //     );
                //   } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.381,
                        child: Text(
                          productDataArray["category_name"],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 211, 210, 210)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.319,
                        child: Text(
                          productDataArray["brand_name"],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 211, 210, 210)),
                        ),
                      ),
                    ],
                  ),
                );
              }
              // } else {
              //   return Center();
              // }
              // }
              ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
