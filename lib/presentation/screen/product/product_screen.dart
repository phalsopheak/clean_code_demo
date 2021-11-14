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
          )
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: productController.listProduct
                  .map(
                    (x) => ListTile(
                      title: Text(x.name),
                      subtitle: Text(x.category),
                      leading: x.picture == null
                          ? const Icon(Icons.image)
                          : Image.network(x.picture!),
                    ),
                  )
                  .toList(),
            ),
          )),
    );
  }
}
