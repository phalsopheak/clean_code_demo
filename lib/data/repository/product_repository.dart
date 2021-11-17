import 'package:demo_clean_code/data/datasource/product_datasource.dart';
import 'package:demo_clean_code/data/model/product_model.dart';
import 'package:demo_clean_code/domain/repository/product_repository_interface.dart';

class ProductRepository extends IProductRepository {
  final IProductDataSource? productDataSource;

  ProductRepository({this.productDataSource});

  @override
  List<ProductModel> getAllProduct() {
    List<ProductModel> listProduct = productDataSource!.getAllProduct();
    return listProduct;
  }

  @override
  int addProduct(ProductModel model) {
    var id = productDataSource!.addProduct(model);
    return id;
  }

  @override
  int editProduct(ProductModel model) {
    var id = productDataSource!.editProduct(model);
    return id;
  }

  @override
  int deleteProduct(int recordId) {
    var id = productDataSource!.deleteProduct(recordId);
    return id;
  }
}
