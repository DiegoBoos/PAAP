import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/convocatoria_entity.dart';

abstract class ConvocatoriaRepositoryDB {
  Future<Either<Failure, List<ConvocatoriaEntity>>>
      getConvocatoriasRepositoryDB();

  Future<Either<Failure, ConvocatoriaEntity>> saveConvocatoriaRepositoryDB(
      ConvocatoriaEntity convocatoriaEntity);
}
