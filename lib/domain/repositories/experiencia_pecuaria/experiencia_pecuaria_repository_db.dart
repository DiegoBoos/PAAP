import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/experiencia_pecuaria_entity.dart';

abstract class ExperienciaPecuariaRepositoryDB {
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasProduccionRepositoryDB();

  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasRepositoryDB();

  Future<Either<Failure, ExperienciaPecuariaEntity?>>
      getExperienciaPecuariaRepositoryDB(
          String tipoActividadProductivaId, String beneficiarioId);

  Future<Either<Failure, int>> saveExperienciasPecuariasRepositoryDB(
      List<ExperienciaPecuariaEntity> experienciasPecuarias);

  Future<Either<Failure, int>> saveExperienciaPecuariaRepositoryDB(
      ExperienciaPecuariaEntity experienciaPecuariaEntity);

  Future<Either<Failure, int>>
      updateExperienciasPecuariasProduccionDBRepositoryDB(
          List<ExperienciaPecuariaEntity> experienciasPecuariasEntity);
}
