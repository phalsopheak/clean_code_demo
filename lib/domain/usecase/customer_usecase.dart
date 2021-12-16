import 'package:demo_clean_code/data/model/customer_model.dart';
import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/repository/customer_repository_interface.dart';
import 'package:demo_clean_code/domain/usecase/usecase.dart';

class GetAllCustomerUseCase
    extends UseCaseFuture<List<CustomerModel>, NoParam> {
  final ICustomerRepository? customerRepository;

  GetAllCustomerUseCase({this.customerRepository});

  @override
  Future<List<CustomerModel>> call(NoParam params) async {
    List<CustomerModel> listProduct =
        await customerRepository!.getAllCustomer();
    return listProduct;
  }
}

class AddCustomerUseCase extends UseCaseFuture<int, CustomerModel> {
  final ICustomerRepository? customerRepository;

  AddCustomerUseCase({this.customerRepository});

  @override
  Future<int> call(CustomerModel params) async {
    var id = await customerRepository!.addCustomer(params);
    return id;
  }
}
