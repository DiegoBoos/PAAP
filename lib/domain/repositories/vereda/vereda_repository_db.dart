import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/vereda_entity.dart';

abstract class VeredaRepositoryDB {
  Future<Either<Failure, List<VeredaEntity>>> getVeredasRepositoryDB();

  Future<Either<Failure, int>> saveVeredasRepositoryDB(
      List<VeredaEntity> veredaEntity);
}
