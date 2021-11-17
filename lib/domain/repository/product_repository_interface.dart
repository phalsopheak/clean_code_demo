import 'package:demo_clean_code/data/model/product_model.dart';

abstract class IProductRepository {
  List<ProductModel> getAllProduct();
  int addProduct(ProductModel model);
  int editProduct(ProductModel model);
  int deleteProduct(int recordId);
}
