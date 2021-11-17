import 'package:demo_clean_code/data/model/product_model.dart';
import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/usecase/product_usecase.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetAllProductUseCase? getAllProductUseCase;
  final AddProductUseCase? addProductUseCase;
  final EditProductUseCase? editProductUseCase;
  final DeleteProductUseCase? deleteProductUseCase;

  var listProduct = RxList<ProductModel>();

  var selectedProduct = ProductModel(
    id: 0,
    name: '',
    price: 1,
    category: 'selected',
  );

  ProductController({
    this.getAllProductUseCase,
    this.addProductUseCase,
    this.editProductUseCase,
    this.deleteProductUseCase,
  });

  selectProduct(ProductModel model) {
    selectedProduct = model;
  }

  loadProduct() {
    listProduct.clear();
    var list = getAllProductUseCase!.call(NoParam());
    listProduct.assignAll(list);
  }

  int addProduct(ProductModel model) {
    var id = addProductUseCase!.call(model);
    listProduct.add(model);
    Get.back();
    return id;
  }

  int editProduct(ProductModel model) {
    var id = editProductUseCase!.call(model);

    var index = listProduct.indexWhere(
      (x) => x.id == model.id,
    );

    listProduct[index] = model;
    listProduct.refresh();
    Get.back();
    return id;
  }

  int deleteProduct(int recordId) {
    var id = deleteProductUseCase!.call(recordId);
    listProduct.removeWhere((x) => x.id == recordId);
    return id;
  }

  sortAZ() {
    listProduct.sort((a, b) => a.name.compareTo(b.name));
  }

  sortZA() {
    listProduct.sort((a, b) => b.name.compareTo(a.name));
  }

  sortPriceAcs() {
    listProduct.sort((a, b) => b.price.compareTo(a.price));
  }
}
