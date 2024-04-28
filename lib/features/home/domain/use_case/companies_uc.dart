

import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/compony_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class GetCompaniesUseCase extends BaseUseCase<List<CompanyModel>,NoParameter>{
  final BaseRepositoryHome baseRepositoryHome;

  GetCompaniesUseCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<CompanyModel>, Failure>> call(NoParameter parameter) async {
    final result = await baseRepositoryHome.getCompanies();
    return result;
  }
}