import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/alianza_experiencia_pecuaria_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_repository.dart';

class AlianzaExperienciaPecuariaUsecase {
  final AlianzaExperienciaPecuariaRepository repository;

  AlianzaExperienciaPecuariaUsecase(this.repository);

  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasUsecase(UsuarioEntity usuario) {
    return repository.getAlianzasExperienciasPecuariasRepository(usuario);
  }

  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      saveAlianzasExperienciasPecuariasUsecase(
          UsuarioEntity usuario,
          List<AlianzaExperienciaPecuariaEntity>
              alianzaExperienciaPecuariaEntity) {
    return repository.saveAlianzasExperienciasPecuariasRepository(
        usuario, alianzaExperienciaPecuariaEntity);
  }
}
