import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/visita_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class VisitaRepository {
  Future<Either<Failure, int>> saveVisitaRepository(
      UsuarioEntity usuario, VisitaEntity visitaEntity);
}
