import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/proyecto_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/proyecto/proyecto_repository.dart';

class ProyectoUsecase {
  final ProyectoRepository repository;

  ProyectoUsecase(this.repository);

  Future<Either<Failure, List<ProyectoEntity>>> getProyectosUsecase(
      UsuarioEntity usuario) {
    return repository.getProyectosRepository(usuario);
  }
}
