import 'package:demo_clean_code/data/model/product_model.dart';
import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/repository/product_repository_interface.dart';
import 'package:demo_clean_code/domain/usecase/usecase.dart';

class GetAllProductUseCase extends UseCase<List<ProductModel>, NoParam> {
  final IProductRepository? productRepository;

  GetAllProductUseCase({this.productRepository});

  @override
  List<ProductModel> call(NoParam params) {
    List<ProductModel> listProduct = productRepository!.getAllProduct();
    return listProduct;
  }
}

class AddProductUseCase extends UseCase<int, ProductModel> {
  final IProductRepository? productRepository;

  AddProductUseCase({this.productRepository});

  @override
  int call(ProductModel model) {
    var id = productRepository!.addProduct(model);
    return id;
  }
}