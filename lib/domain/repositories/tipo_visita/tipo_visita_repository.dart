import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_visita_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoVisitaRepository {
  Future<Either<Failure, List<TipoVisitaEntity>>> getTiposVisitasRepository(
      UsuarioEntity usuario);
}
