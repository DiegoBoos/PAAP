import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/municipio_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/municipio/municipio_repository.dart';

class MunicipioUsecase {
  final MunicipioRepository repository;

  MunicipioUsecase(this.repository);

  Future<Either<Failure, List<MunicipioEntity>>> getMunicipiosUsecase(
      UsuarioEntity usuario) {
    return repository.getMunicipiosRepository(usuario);
  }
}
