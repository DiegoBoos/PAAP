import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

import '../../entities/perfil_cofinanciador_entity.dart';
import '../../repositories/perfil_cofinanciador/perfil_cofinanciador_repository_db.dart';

class PerfilCofinanciadorUsecaseDB {
  final PerfilCofinanciadorRepositoryDB repositoryDB;

  PerfilCofinanciadorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilCofinanciadoresUsecaseDB(String perfilId) {
    return repositoryDB.getPerfilCofinanciadoresRepositoryDB(perfilId);
  }

  Future<Either<Failure, PerfilCofinanciadorEntity?>>
      getPerfilCofinanciadorUsecaseDB(String perfilId, String cofinanciadorId) {
    return repositoryDB.getPerfilCofinanciadorRepositoryDB(
        perfilId, cofinanciadorId);
  }

  Future<Either<Failure, int>> savePerfilCofinanciadoresUsecaseDB(
      List<PerfilCofinanciadorEntity> perfilCofinanciadores) {
    return repositoryDB
        .savePerfilCofinanciadoresRepositoryDB(perfilCofinanciadores);
  }

  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilesCofinanciadoresProduccionUsecaseDB() {
    return repositoryDB.getPerfilesCofinanciadoresProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilCofinanciadorUsecaseDB(
      PerfilCofinanciadorEntity perfilCofinanciadorEntity) {
    return repositoryDB
        .savePerfilCofinanciadorRepositoryDB(perfilCofinanciadorEntity);
  }

  Future<Either<Failure, int>> updatePerfilesCofinanciadoresProduccionUsecaseDB(
      List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity) {
    return repositoryDB.updatePerfilesCofinanciadoresProduccionDBRepositoryDB(
        perfilesCofinanciadoresEntity);
  }
}
