import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/convocatoria_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/convocatoria/convocatoria_repository.dart';

class ConvocatoriaUsecase {
  final ConvocatoriaRepository repository;

  ConvocatoriaUsecase(this.repository);

  Future<Either<Failure, List<ConvocatoriaEntity>>> getConvocatoriasUsecase(
      UsuarioEntity usuario) {
    return repository.getConvocatoriasRepository(usuario);
  }
}
