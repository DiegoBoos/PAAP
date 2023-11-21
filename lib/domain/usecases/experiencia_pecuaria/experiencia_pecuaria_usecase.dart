import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/experiencia_pecuaria_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/experiencia_pecuaria/experiencia_pecuaria_repository.dart';

class ExperienciaPecuariaUsecase {
  final ExperienciaPecuariaRepository repository;

  ExperienciaPecuariaUsecase(this.repository);

  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasUsecase(UsuarioEntity usuario) {
    return repository.getExperienciasPecuariasRepository(usuario);
  }

  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      saveExperienciasPecuariasUsecase(UsuarioEntity usuario,
          List<ExperienciaPecuariaEntity> experienciaPecuariaEntity) {
    return repository.saveExperienciasPecuariasRepository(
        usuario, experienciaPecuariaEntity);
  }
}
