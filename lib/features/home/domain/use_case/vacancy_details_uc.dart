
import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class  GetVacancyDetailsUseCase extends BaseUseCase<List<VacancyModel>, int> {
  final BaseRepositoryHome baseRepositoryHome;

  GetVacancyDetailsUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<VacancyModel>, Failure>> call(int parameter) async {
    final result = await baseRepositoryHome.getJobDetails(parameter);

    return result;
  }
}
