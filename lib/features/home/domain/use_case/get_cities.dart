import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class GetCitiesUseCase extends BaseUseCase<List<Country>, NoParameter> {
  final BaseRepositoryHome baseRepositoryHome;

  GetCitiesUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<Country>, Failure>> call(NoParameter parameter) async {
    final result = await baseRepositoryHome.getCities();

    return result;
  }
}
