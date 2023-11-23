import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

import '../../entities/perfil_aliado_entity.dart';
import '../../repositories/perfil_aliado/perfil_aliado_repository_db.dart';

class PerfilAliadoUsecaseDB {
  final PerfilAliadoRepositoryDB repositoryDB;

  PerfilAliadoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilAliadoEntity>>> getPerfilAliadosUsecaseDB(
      String perfilId) {
    return repositoryDB.getPerfilAliadosRepositoryDB(perfilId);
  }

  Future<Either<Failure, PerfilAliadoEntity?>> getPerfilAliadoUsecaseDB(
      String perfilId, String aliadoId) {
    return repositoryDB.getPerfilAliadoRepositoryDB(perfilId, aliadoId);
  }

  Future<Either<Failure, int>> savePerfilAliadosUsecaseDB(
      List<PerfilAliadoEntity> perfilAliados) {
    return repositoryDB.savePerfilAliadosRepositoryDB(perfilAliados);
  }

  Future<Either<Failure, List<PerfilAliadoEntity>>>
      getPerfilesAliadosProduccionUsecaseDB() {
    return repositoryDB.getPerfilesAliadosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilAliadoUsecaseDB(
      PerfilAliadoEntity perfilAliadoEntity) {
    return repositoryDB.savePerfilAliadoRepositoryDB(perfilAliadoEntity);
  }

  Future<Either<Failure, int>> updatePerfilesAliadosProduccionUsecaseDB(
      List<PerfilAliadoEntity> perfilesAliadosEntity) {
    return repositoryDB
        .updatePerfilesAliadosProduccionDBRepositoryDB(perfilesAliadosEntity);
  }
}
