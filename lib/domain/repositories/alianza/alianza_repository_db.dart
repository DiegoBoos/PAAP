import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_entity.dart';
import '../../entities/v_alianza_entity.dart';

abstract class AlianzaRepositoryDB {
  Future<Either<Failure, List<VAlianzaEntity>>> getAlianzasRepositoryDB();
  Future<Either<Failure, List<VAlianzaEntity>>> getAlianzasFiltrosRepositoryDB(
      String id, String nombre);

  Future<Either<Failure, int>> saveAlianzasRepositoryDB(
      List<AlianzaEntity> alianzaEntity);
}
