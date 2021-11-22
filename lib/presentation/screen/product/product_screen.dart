import 'package:demo_clean_code/core/constant/app_route.dart';
import 'package:demo_clean_code/presentation/controller/product_controller.dart';
import 'package:demo_clean_code/presentation/widget/textbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController productController = Get.find();

  late TextEditingController tecSearchName;
  late TextEditingController tecSearchPrice;
  @override
  void initState() {
    tecSearchName = TextEditingController();
    tecSearchPrice = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tecSearchName.dispose();
    tecSearchPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () => productController.loadProduct(),
            icon: const Icon(Icons.list_alt),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoute.addProduct),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => productController.sortAZ(),
            icon: const Icon(Icons.sort_by_alpha),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextBox(
                    label: 'Search Name',
                    controller: tecSearchName,
                    onChanged: (x) {
                      productController.searchProduct(x);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextBox(
                    label: 'Price',
                    controller: tecSearchPrice,
                    onChanged: (x) {
                      productController.searchProduct(tecSearchName.text,
                          priceSearch: double.tryParse(x) ?? 0);
                    },
                  ),
                ),
                Column(
                  children: productController.listSearchProduct
                      .map(
                        (x) => ListTile(
                          title: Text(x.name + ' ' + x.price.toString()),
                          subtitle: Text(x.category),
                          leading: x.picture == null
                              ? const Icon(Icons.image)
                              : Image.network(x.picture!),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    productController.selectProduct(x);
                                    Get.toNamed(AppRoute.editProduct);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    productController.deleteProduct(x.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          )),
    );
  }
}
