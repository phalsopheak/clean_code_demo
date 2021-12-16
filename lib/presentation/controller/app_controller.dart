import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/usecase/app_usecase.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final CreateFolderUseCase? createFolderUseCase;

  AppController({this.createFolderUseCase});

  @override
  void onInit() {
    createFolder();
    super.onInit();
  }

  createFolder() async {
    var id = await createFolderUseCase!.call(NoParam());
    return id;
  }
}
