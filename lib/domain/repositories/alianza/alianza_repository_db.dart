import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_entity.dart';
import '../../entities/v_alianza_entity.dart';

abstract class AlianzaRepositoryDB {
  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasRepositoryDB();
  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasFiltrosRepositoryDB(
      String id, String nombre);

  Future<Either<Failure, VAlianzaEntity?>> getAlianzaRepositoryDB(String id);

  Future<Either<Failure, int>> saveAlianzasRepositoryDB(
      List<AlianzaEntity> alianzaEntity);
}
