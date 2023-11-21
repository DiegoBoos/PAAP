import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/consultor_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/consultor/consultor_repository.dart';

class ConsultorUsecase {
  final ConsultorRepository repository;

  ConsultorUsecase(this.repository);

  Future<Either<Failure, List<ConsultorEntity>>> getConsultoresUsecase(
      UsuarioEntity usuario) {
    return repository.getConsultoresRepository(usuario);
  }
}
