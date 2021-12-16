import 'package:demo_clean_code/data/datasource/sqflite/customer_datasource.dart';
import 'package:demo_clean_code/data/model/customer_model.dart';

import 'package:demo_clean_code/domain/repository/customer_repository_interface.dart';

class CustomerRepository extends ICustomerRepository {
  final ICustomerDataSource? customerDataSource;

  CustomerRepository({this.customerDataSource});

  @override
  Future<List<CustomerModel>> getAllCustomer() async {
    List<CustomerModel> listCustomer = await customerDataSource!.readCustomer();
    return listCustomer;
  }

  @override
  Future<int> addCustomer(CustomerModel model) async {
    var id = await customerDataSource!.createCustomer(model);
    return id;
  }
}
