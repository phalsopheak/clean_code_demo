import 'package:demo_clean_code/domain/entity/no_param.dart';
import 'package:demo_clean_code/domain/repository/app_repository_interface.dart';
import 'package:demo_clean_code/domain/usecase/usecase.dart';

class CreateFolderUseCase extends UseCaseFuture<int, NoParam> {
  final IAppRepository? appRepository;

  CreateFolderUseCase({this.appRepository});

  @override
  Future<int> call(NoParam params) async {
    return await appRepository!.createFolder();
  }
}
