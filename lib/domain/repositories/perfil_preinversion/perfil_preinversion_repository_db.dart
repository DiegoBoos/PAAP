import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/v_perfil_preinversion_entity.dart';

abstract class PerfilPreInversionRepositoryDB {
  Future<Either<Failure, List<VPerfilPreInversionEntity>>>
      getPerfilesPreInversionRepositoryDB();
  Future<Either<Failure, List<VPerfilPreInversionEntity>>>
      getPerfilesPreInversionFiltrosRepositoryDB(String? id, String? nombre);
  Future<Either<Failure, int>> savePerfilesPreInversionRepositoryDB(
      List<PerfilPreInversionEntity> perfilesPreInversion);
}
