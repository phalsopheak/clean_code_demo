import 'package:demo_clean_code/data/model/product_model.dart';
import 'package:demo_clean_code/presentation/controller/product_controller.dart';
import 'package:demo_clean_code/presentation/widget/textbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ProductController productController = Get.find();
  late TextEditingController tecId;
  late TextEditingController tecName;
  late TextEditingController tecPrice;
  late TextEditingController tecCategory;
  late FocusNode fnId;
  late FocusNode fnName;

  @override
  void initState() {
    tecId = TextEditingController();
    tecName = TextEditingController();
    tecPrice = TextEditingController();
    tecCategory = TextEditingController();

    tecId.text = productController.selectedProduct.id.toString();
    tecName.text = productController.selectedProduct.name;
    tecPrice.text = productController.selectedProduct.price.toString();
    tecCategory.text = productController.selectedProduct.category;

    fnId = FocusNode();
    fnName = FocusNode();
    fnId.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    fnName.dispose();
    fnId.dispose();
    tecId.dispose();
    tecName.dispose();
    tecPrice.dispose();
    tecCategory.dispose();
    super.dispose();
  }

  bool isValid() {
    var b = true;
    if (tecName.text == '') {
      fnName.requestFocus();
      b = false;
    }
    return b;
  }

  editProduct() {
    if (isValid()) {
      var model = ProductModel(
        id: int.tryParse(tecId.text) ?? 0,
        name: tecName.text,
        price: double.tryParse(tecPrice.text) ?? 0,
        category: tecCategory.text,
      );
      productController.editProduct(model);
    } else {
      Get.snackbar('Error', 'Please input name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        actions: [
          IconButton(
            onPressed: () => editProduct(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextBox(
              focusNode: fnId,
              label: 'id',
              controller: tecId,
            ),
            TextBox(
              label: 'name',
              focusNode: fnName,
              controller: tecName,
            ),
            TextBox(
              label: 'price',
              controller: tecPrice,
            ),
            TextBox(
              label: 'category',
              controller: tecCategory,
            ),
          ],
        ),
      ),
    );
  }
}
