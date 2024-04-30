import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class GetUniversityUseCase
    extends BaseUseCase<List<UniversityModel>, NoParameter> {
  final BaseRepositoryHome baseRepositoryHome;

  GetUniversityUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<UniversityModel>, Failure>> call(
      NoParameter parameter) async {
    final result = await baseRepositoryHome.getUniversity();

    return result;
  }
}class GetSkillsUseCase
    extends BaseUseCase<List<SkillModel>, NoParameter> {
  final BaseRepositoryHome baseRepositoryHome;

  GetSkillsUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<SkillModel>, Failure>> call(
      NoParameter parameter) async {
    final result = await baseRepositoryHome.getSkill();

    return result;
  }
}
