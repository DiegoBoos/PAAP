import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/aliado_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AliadoPreinversionRepository {
  Future<Either<Failure, List<AliadoPreinversionEntity>>>
      getAliadosPreinversionRepository(UsuarioEntity usuario);
}
