import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_aliado_entity.dart';

abstract class PerfilPreInversionAliadoRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilPreInversionAliadosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionAliadoEntity?>>
      getPerfilPreInversionAliadoRepositoryDB(String id);

  Future<Either<Failure, int>> savePerfilPreInversionAliadosRepositoryDB(
      List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadoEntity);
}
