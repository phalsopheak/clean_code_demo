import 'package:demo_clean_code/data/datasource/sqflite/sqflite_instance.dart';
import 'package:demo_clean_code/data/model/customer_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ICustomerDataSource {
  Future<int> createCustomer(CustomerModel model);
  Future<int> updateCustomer(CustomerModel model);
  Future<int> deleteCustomer(int recordId);
  Future<List<CustomerModel>> readCustomer();
}

class CustomerDataSource extends ICustomerDataSource {
  @override
  Future<int> createCustomer(CustomerModel model) async {
    var id = await SqfliteInstance.instance
        .create(map: model.toMap(), tableName: CustomerModel.tableName);
    return id;
  }

  @override
  Future<int> updateCustomer(CustomerModel model) async {
    return 1;
    // var id = await SqfliteInstance.instance
    //     .update(map: model.toMap(), tableName: CustomerModel.tableName);
    // return id;
  }

  @override
  Future<List<CustomerModel>> readCustomer() async {
 
    var json = await SqfliteInstance.instance.read(tableName: CustomerModel.tableName);
    List<CustomerModel> list = [];
    for (var x in json) {
        list.add(CustomerModel.fromMap(x));
      }
    return list;
  }

  @override
  Future<int> deleteCustomer(int recordId) async {
    return 1;
    // Database db = await SqfliteInstance.instance.database;
    // int updateCount = await db.rawUpdate('''
    // UPDATE ${CustomerModel.tableName}
    // SET ${CustomerModel.columnActive} = ?
    // WHERE ${CustomerModel.columnId} = ?
    // ''', [0, recordId]);
    // return updateCount;
  }
}
