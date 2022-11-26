import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/municipio_entity.dart';

abstract class MunicipioRepositoryDB {
  Future<Either<Failure, List<MunicipioEntity>>> getMunicipiosRepositoryDB();

  Future<Either<Failure, int>> saveMunicipiosRepositoryDB(
      List<MunicipioEntity> municipioEntity);

  Future<Either<Failure, List<MunicipioEntity>>>
      getMunicipiosByDepartamentoRepositoryDB(String departamentoId);

  Future<Either<Failure, List<String>>> getMunicipiosIdsRepositoryDB();
}
