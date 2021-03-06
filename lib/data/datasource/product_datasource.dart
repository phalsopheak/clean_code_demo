import 'package:demo_clean_code/data/model/product_model.dart';

abstract class IProductDataSource {
  List<ProductModel> getAllProduct();
  int addProduct(ProductModel model);
  int editProduct(ProductModel model);
  int deleteProduct(int recordId);
}

class ProductDataSource extends IProductDataSource {
  List<ProductModel> listProduct = [
    ProductModel(
      id: 1,
      name: 'Coca cola',
      price: 6,
      category: 'Drink',
    ),
    ProductModel(
      id: 2,
      name: 'Pepsi',
      price: 0.5,
      category: 'Drink',
    ),
    ProductModel(
        id: 3,
        name: 'Hakav',
        price: 5,
        category: 'Dimsam',
        picture:
            'https://www.honestfoodtalks.com/wp-content/uploads/2020/02/best-dim-sum-xiao-long-bao-soup-dumpling.jpg'),
    ProductModel(
        id: 4,
        name: 'Num Pav',
        price: 1,
        category: 'Dimsam',
        picture:
            'https://www.honestfoodtalks.com/wp-content/uploads/2020/02/best-dim-sum-xiao-long-bao-soup-dumpling.jpg'),
  ];

  @override
  List<ProductModel> getAllProduct() {
    return listProduct;
  }

  @override
  int addProduct(ProductModel model) {
    listProduct.add(model);
    return model.id;
  }

  @override
  int editProduct(ProductModel model) {
    var id = listProduct.indexWhere(
      (x) => x.id == model.id,
    );

    listProduct[id] = model;

    return model.id;
  }

  @override
  int deleteProduct(int recordId) {
    listProduct.removeWhere((x) => x.id == recordId);
    return recordId;
  }
}
