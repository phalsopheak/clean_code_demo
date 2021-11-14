import 'package:demo_clean_code/data/model/product_model.dart';

abstract class IProductDataSource {
  List<ProductModel> getAllProduct();
  int addProduct(ProductModel model);
}

class ProductDataSource extends IProductDataSource {
  List<ProductModel> listProduct = [
    ProductModel(
      id: 1,
      name: 'Coca cola',
      price: 0.8,
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
            'https://lh3.googleusercontent.com/proxy/etQ7euchEiVYZIxVEJnQW_ZaCYboE-Jj5JoCEHb3GObjh1Oz207wmJjjXVnYSGXC_IKMoHIokx5X4dykIfoHzzGQgiZxA5hCspdfmrygDUV0MmXgkwgqeirMJJIbABpYIYQrcDCXUnk'),
    ProductModel(
        id: 4,
        name: 'Num Pav',
        price: 6,
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
}
