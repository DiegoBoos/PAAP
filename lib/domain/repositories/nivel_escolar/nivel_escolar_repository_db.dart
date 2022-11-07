import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/nivel_escolar_entity.dart';

abstract class NivelEscolarRepositoryDB {
  Future<Either<Failure, List<NivelEscolarEntity>>>
      getNivelesEscolaresRepositoryDB();

  Future<Either<Failure, int>> saveNivelesEscolaresRepositoryDB(
      List<NivelEscolarEntity> nivelEscolarEntity);
}
