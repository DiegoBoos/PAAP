import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/v_perfil_preinversion_entity.dart';

abstract class PerfilPreinversionRepositoryDB {
  Future<Either<Failure, List<VPerfilPreinversionEntity>>>
      getPerfilesPreinversionRepositoryDB();
  Future<Either<Failure, List<VPerfilPreinversionEntity>>>
      getPerfilesPreinversionFiltrosRepositoryDB(String? id, String? nombre);
  Future<Either<Failure, int>> savePerfilesPreinversionRepositoryDB(
      List<PerfilPreinversionEntity> perfilesPreinversion);
}
