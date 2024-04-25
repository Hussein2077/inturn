import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class GetFacultyUseCase extends BaseUseCase<List<FacultyModel>, int> {
  final BaseRepositoryHome baseRepositoryHome;

  GetFacultyUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<FacultyModel>, Failure>> call(int parameter) async {
    final result = await baseRepositoryHome.getFaculty(parameter);

    return result;
  }
}
