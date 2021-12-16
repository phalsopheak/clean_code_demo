import 'dart:io';

import 'package:demo_clean_code/core/constant/app_directory.dart';
import 'package:demo_clean_code/domain/repository/app_repository_interface.dart';
import 'package:path_provider/path_provider.dart';

class AppRepository extends IAppRepository {
  @override
  Future<int> createFolder() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      var productImagePath = Directory(directory.path + AppDirectory.appImage);

      if (await productImagePath.exists() == false) {
        productImagePath.create();
      }

      return (1);
    } catch (e) {
      return (0);
    }
  }
}
