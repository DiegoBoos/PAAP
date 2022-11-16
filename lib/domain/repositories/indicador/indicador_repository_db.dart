import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/indicador_entity.dart';

abstract class IndicadorRepositoryDB {
  Future<Either<Failure, List<IndicadorEntity>>> getIndicadoresRepositoryDB();
  Future<Either<Failure, IndicadorEntity?>> getIndicadorRepositoryDB(String id);

  Future<Either<Failure, int>> saveIndicadoresRepositoryDB(
      List<IndicadorEntity> indicadorEntity);
}
