import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_consultor_entity.dart';

abstract class PerfilPreInversionConsultorRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilPreInversionConsultoresRepositoryDB();

  Future<Either<Failure, PerfilPreInversionConsultorEntity?>>
      getPerfilPreInversionConsultorRepositoryDB(String id);

  Future<Either<Failure, int>> savePerfilPreInversionConsultoresRepositoryDB(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity);
}
