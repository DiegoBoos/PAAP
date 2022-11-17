import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/experiencia_pecuaria_entity.dart';

abstract class ExperienciaPecuariaRepositoryDB {
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasRepositoryDB();

  Future<Either<Failure, ExperienciaPecuariaEntity?>>
      getExperienciaPecuariaRepositoryDB(String id);

  Future<Either<Failure, int>> saveExperienciasPecuariasRepositoryDB(
      List<ExperienciaPecuariaEntity> experienciasPecuarias);
}
