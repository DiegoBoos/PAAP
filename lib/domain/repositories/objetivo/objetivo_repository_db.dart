import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/objetivo_entity.dart';

abstract class ObjetivoRepositoryDB {
  Future<Either<Failure, List<ObjetivoEntity>>> getObjetivosRepositoryDB();

  Future<Either<Failure, int>> saveObjetivosRepositoryDB(
      List<ObjetivoEntity> objetivoEntity);
}
