import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/aliado_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/aliado_preinversion/aliado_preinversion_repository.dart';

class AliadoPreinversionUsecase {
  final AliadoPreinversionRepository repository;

  AliadoPreinversionUsecase(this.repository);

  Future<Either<Failure, List<AliadoPreinversionEntity>>>
      getAliadosPreinversionUsecase(UsuarioEntity usuario) {
    return repository.getAliadosPreinversionRepository(usuario);
  }
}
