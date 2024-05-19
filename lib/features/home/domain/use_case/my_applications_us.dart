import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/application_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class GetMyApplicationsUseCase extends BaseUseCase<List<ApplicationModel>,String>{
  final BaseRepositoryHome baseRepositoryHome;

  GetMyApplicationsUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<ApplicationModel>, Failure>> call(String parameter) async {
    final result = await baseRepositoryHome.getMyApplications(parameter);

    return result;
  }
}
