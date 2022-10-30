import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_proyecto_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_proyecto/tipo_proyecto_repository.dart';

class TipoProyectoUsecase {
  final TipoProyectoRepository repository;

  TipoProyectoUsecase(this.repository);

  Future<Either<Failure, List<TipoProyectoEntity>>> getTiposProyectosUsecase(
      UsuarioEntity usuario) {
    return repository.getTiposProyectosRepository(usuario);
  }
}
