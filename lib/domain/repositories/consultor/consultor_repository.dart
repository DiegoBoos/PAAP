import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/consultor_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ConsultorRepository {
  Future<Either<Failure, List<ConsultorEntity>>> getConsultoresRepository(
      UsuarioEntity usuario);
}
