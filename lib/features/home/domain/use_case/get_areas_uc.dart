import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class GetAreaUseCase extends BaseUseCase<List<AreaModel>, int> {
  final BaseRepositoryHome baseRepositoryHome;
  GetAreaUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<AreaModel>, Failure>> call(int parameter) async {
    final result = await baseRepositoryHome.getAreas(parameter);

    return result;
  }
}
