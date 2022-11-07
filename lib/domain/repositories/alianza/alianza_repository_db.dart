import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_entity.dart';

abstract class AlianzaRepositoryDB {
  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasRepositoryDB();

  Future<Either<Failure, int>> saveAlianzasRepositoryDB(
      List<AlianzaEntity> alianzaEntity);
}
