import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/meta_indicador_entity.dart';

abstract class MetaIndicadorRepositoryDB {
  Future<Either<Failure, List<MetaIndicadorEntity>>>
      getMetasIndicadoresRepositoryDB();

  Future<Either<Failure, int>> saveMetasIndicadoresRepositoryDB(
      List<MetaIndicadorEntity> metaIndicadorEntity);
}
