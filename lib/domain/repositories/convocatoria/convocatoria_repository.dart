import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/convocatoria_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ConvocatoriaRepository {
  Future<Either<Failure, List<ConvocatoriaEntity>>> getConvocatoriasRepository(
      UsuarioEntity usuario);
}
