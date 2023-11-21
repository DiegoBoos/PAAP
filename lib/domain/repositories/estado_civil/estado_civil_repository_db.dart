import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/estado_civil_entity.dart';

abstract class EstadoCivilRepositoryDB {
  Future<Either<Failure, List<EstadoCivilEntity>>>
      getEstadosCivilesRepositoryDB();

  Future<Either<Failure, int>> saveEstadosCivilesRepositoryDB(
      List<EstadoCivilEntity> estadocivilEntity);
}
