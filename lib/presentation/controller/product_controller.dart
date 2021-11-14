import 'package:demo_clean_code/data/model/product_model.dart';
import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/usecase/product_usecase.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetAllProductUseCase? getAllProductUseCase;
  final AddProductUseCase? addProductUseCase;

  var listProduct = RxList<ProductModel>();

  ProductController({
    this.getAllProductUseCase,
    this.addProductUseCase,
  });

  loadProduct() {
    listProduct.clear();
    var list = getAllProductUseCase!.call(NoParam());
    listProduct.assignAll(list);
  }

  int addProduct(ProductModel model) {
    var id = addProductUseCase!.call(model);
    //listProduct.add(model);
    loadProduct();
    Get.back();
    return id;
  }
}
