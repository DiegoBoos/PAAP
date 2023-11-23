import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_aliado_entity.dart';

abstract class PerfilAliadoRepositoryDB {
  Future<Either<Failure, List<PerfilAliadoEntity>>>
      getPerfilesAliadosProduccionRepositoryDB();

  Future<Either<Failure, List<PerfilAliadoEntity>>>
      getPerfilAliadosRepositoryDB(String perfilId);

  Future<Either<Failure, PerfilAliadoEntity?>> getPerfilAliadoRepositoryDB(
      String perfilId, String aliadoId);

  Future<Either<Failure, int>> savePerfilAliadosRepositoryDB(
      List<PerfilAliadoEntity> perfilAliados);

  Future<Either<Failure, int>> savePerfilAliadoRepositoryDB(
      PerfilAliadoEntity perfilAliadoEntity);

  Future<Either<Failure, int>> updatePerfilesAliadosProduccionDBRepositoryDB(
      List<PerfilAliadoEntity> perfilesAliadosEntity);
}
