import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/vereda_entity.dart';

abstract class VeredaRepositoryDB {
  Future<Either<Failure, List<VeredaEntity>>> getVeredasByMunicipioRepositoryDB(
      String municipioId);

  Future<Either<Failure, int>> saveVeredasRepositoryDB(
      List<VeredaEntity> veredaEntity);
}
