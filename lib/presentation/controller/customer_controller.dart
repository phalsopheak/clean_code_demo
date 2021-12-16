import 'package:demo_clean_code/data/model/customer_model.dart';
import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/usecase/customer_usecase.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  final AddCustomerUseCase? addCustomerUseCase;
  final GetAllCustomerUseCase? getAllCustomerUseCase;

  var blankCustomer = CustomerModel(
    code: 'code',
    phone: '',
    name: 'name',
    discount: 0,
    note: '',
  );
  late CustomerModel selectedCustomer;
  var listCustomer = RxList<CustomerModel>();

  var isLoading = false.obs;

  CustomerController({
    this.addCustomerUseCase,
    this.getAllCustomerUseCase,
  });

  @override
  void onInit() {
    super.onInit();
  }

  loadData() async {
    isLoading.value = true;
    selectedCustomer = blankCustomer;
    listCustomer.clear();
    var list = await getAllCustomerUseCase!.call(NoParam());
    listCustomer.assignAll(list);
    isLoading.value = false;
  }

  selectCustomer(CustomerModel model) {
    selectedCustomer = model;
    listCustomer.refresh();
  }

  Future<int> saveData(CustomerModel model) async {
    var recordId = await addCustomerUseCase!.call(model);

    listCustomer.add(model.copyWith(id: recordId));

    return recordId;
  }
}
