import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_cofinanciador_entity.dart';

abstract class PerfilCofinanciadorRepositoryDB {
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilesCofinanciadoresProduccionRepositoryDB();

  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilCofinanciadoresRepositoryDB(String perfilId);

  Future<Either<Failure, PerfilCofinanciadorEntity?>>
      getPerfilCofinanciadorRepositoryDB(
          String perfilId, String cofinanciadorId);

  Future<Either<Failure, int>> savePerfilCofinanciadoresRepositoryDB(
      List<PerfilCofinanciadorEntity> perfilCofinanciadores);

  Future<Either<Failure, int>> savePerfilCofinanciadorRepositoryDB(
      PerfilCofinanciadorEntity perfilCofinanciadorEntity);

  Future<Either<Failure, int>>
      updatePerfilesCofinanciadoresProduccionDBRepositoryDB(
          List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity);
}
