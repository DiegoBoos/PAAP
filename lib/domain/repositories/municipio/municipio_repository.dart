import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/municipio_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class MunicipioRepository {
  Future<Either<Failure, List<MunicipioEntity>>> getMunicipiosRepository(
      UsuarioEntity usuario);
}
