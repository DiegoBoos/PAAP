import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';

abstract class PerfilPreInversionCofinanciadorRubroRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionCofinanciadorRubroEntity?>>
      getPerfilPreInversionCofinanciadorRubroRepositoryDB(String id);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubrosRepositoryDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubroEntity);
}
