import 'package:demo_clean_code/data/model/customer_model.dart';

abstract class ICustomerRepository {
  Future<List<CustomerModel>> getAllCustomer();
  Future<int> addCustomer(CustomerModel model);
}
