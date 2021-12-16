import 'package:demo_clean_code/data/datasource/product_datasource.dart';
import 'package:demo_clean_code/data/datasource/sqflite/customer_datasource.dart';
import 'package:demo_clean_code/data/repository/app_repository.dart';
import 'package:demo_clean_code/data/repository/customer_repository.dart';
import 'package:demo_clean_code/data/repository/product_repository.dart';
import 'package:demo_clean_code/domain/repository/app_repository_interface.dart';
import 'package:demo_clean_code/domain/repository/customer_repository_interface.dart';
import 'package:demo_clean_code/domain/repository/product_repository_interface.dart';
import 'package:demo_clean_code/domain/usecase/app_usecase.dart';
import 'package:demo_clean_code/domain/usecase/customer_usecase.dart';
import 'package:demo_clean_code/domain/usecase/product_usecase.dart';
import 'package:demo_clean_code/presentation/controller/app_controller.dart';
import 'package:demo_clean_code/presentation/controller/customer_controller.dart';
import 'package:demo_clean_code/presentation/controller/product_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    //app

    Get.put<IAppRepository?>(
      AppRepository(),
      permanent: true,
    );
    Get.put<CreateFolderUseCase?>(
      CreateFolderUseCase(appRepository: Get.find()),
      permanent: true,
    );

    Get.put(
      AppController(
        createFolderUseCase: Get.find(),
      ),
      permanent: true,
    );

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
    //customer datasource
    Get.put<ICustomerDataSource?>(
      CustomerDataSource(),
      permanent: true,
    );
    Get.put<ICustomerRepository?>(
      CustomerRepository(customerDataSource: Get.find()),
      permanent: true,
    );
    Get.put<GetAllCustomerUseCase?>(
      GetAllCustomerUseCase(customerRepository: Get.find()),
      permanent: true,
    );
    Get.put<AddCustomerUseCase?>(
      AddCustomerUseCase(customerRepository: Get.find()),
      permanent: true,
    );

    Get.put(
      CustomerController(
        getAllCustomerUseCase: Get.find(),
        addCustomerUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
