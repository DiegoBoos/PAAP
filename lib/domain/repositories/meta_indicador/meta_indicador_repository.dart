import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/meta_indicador_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class MetaIndicadorRepository {
  Future<Either<Failure, List<MetaIndicadorEntity>>>
      getMetasIndicadoresRepository(UsuarioEntity usuario);
}
