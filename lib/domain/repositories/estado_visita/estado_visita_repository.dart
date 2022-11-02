import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/estado_visita_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class EstadoVisitaRepository {
  Future<Either<Failure, List<EstadoVisitaEntity>>> getEstadosVisitasRepository(
      UsuarioEntity usuario);
}
