import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfiles_entity.dart';

import '../../core/error/failure.dart';

abstract class PerfilesRepositoryDB {
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesRepositoryDB();
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesFiltrosRepositoryDB(
      String? id, String? nombre);
  /*  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilesEntity> perfiles); */
}
