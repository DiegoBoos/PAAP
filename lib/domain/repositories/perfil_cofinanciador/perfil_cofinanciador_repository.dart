import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilCofinanciadorRepository {
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilCofinanciadoresRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      savePerfilesCofinanciadoresRepository(UsuarioEntity usuario,
          List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity);
}
