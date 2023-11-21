import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/convocatoria_entity.dart';

abstract class ConvocatoriaRepositoryDB {
  Future<Either<Failure, List<ConvocatoriaEntity>>>
      getConvocatoriasRepositoryDB();

  Future<Either<Failure, int>> saveConvocatoriaRepositoryDB(
      List<ConvocatoriaEntity> convocatoriaEntity);
}
