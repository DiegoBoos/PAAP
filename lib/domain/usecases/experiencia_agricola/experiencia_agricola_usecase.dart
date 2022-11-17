import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/experiencia_agricola_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/experiencia_agricola/experiencia_agricola_repository.dart';

class ExperienciaAgricolaUsecase {
  final ExperienciaAgricolaRepository repository;

  ExperienciaAgricolaUsecase(this.repository);

  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasUsecase(UsuarioEntity usuario) {
    return repository.getExperienciasAgricolasRepository(usuario);
  }

  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      saveExperienciasAgricolasUsecase(UsuarioEntity usuario,
          List<ExperienciaAgricolaEntity> experienciaAgricolaEntity) {
    return repository.saveExperienciasAgricolasRepository(
        usuario, experienciaAgricolaEntity);
  }
}
