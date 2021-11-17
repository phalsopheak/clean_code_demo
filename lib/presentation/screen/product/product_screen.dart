import 'package:demo_clean_code/core/constant/app_route.dart';
import 'package:demo_clean_code/presentation/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.find();
  ProductScreen({Key? key}) : super(key: key);

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
          IconButton(
            onPressed: () => productController.sortZA(),
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () => productController.sortPriceAcs(),
            icon: const Icon(Icons.price_change),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: productController.listProduct
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
          )),
    );
  }
}
