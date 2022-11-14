import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/visita_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class VisitaRepository {
  Future<Either<Failure, List<VisitaEntity>>> getVisitasRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<VisitaEntity>>> saveVisitasRepository(
      UsuarioEntity usuario, List<VisitaEntity> visitaEntity);
}
