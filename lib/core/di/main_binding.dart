import 'package:demo_clean_code/data/datasource/product_datasource.dart';
import 'package:demo_clean_code/data/repository/product_repository.dart';
import 'package:demo_clean_code/domain/repository/product_repository_interface.dart';
import 'package:demo_clean_code/domain/usecase/product_usecase.dart';
import 'package:demo_clean_code/presentation/controller/product_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    //product datasource
    Get.put<IProductDataSource?>(
      ProductDataSource(),
      permanent: true,
    );
    Get.put<IProductRepository?>(
      ProductRepository(productDataSource: Get.find()),
      permanent: true,
    );
    Get.put<GetAllProductUseCase?>(
      GetAllProductUseCase(productRepository: Get.find()),
      permanent: true,
    );
    Get.put<AddProductUseCase?>(
      AddProductUseCase(productRepository: Get.find()),
      permanent: true,
    );
    Get.put<EditProductUseCase?>(
      EditProductUseCase(productRepository: Get.find()),
      permanent: true,
    );
    Get.put<DeleteProductUseCase?>(
      DeleteProductUseCase(productRepository: Get.find()),
      permanent: true,
    );
    Get.put(
      ProductController(
        getAllProductUseCase: Get.find(),
        addProductUseCase: Get.find(),
        editProductUseCase: Get.find(),
        deleteProductUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
