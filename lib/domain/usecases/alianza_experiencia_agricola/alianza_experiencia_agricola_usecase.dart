import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/alianza_experiencia_agricola_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/alianza_experiencia_agricola/alianza_experiencia_agricola_repository.dart';

class AlianzaExperienciaAgricolaUsecase {
  final AlianzaExperienciaAgricolaRepository repository;

  AlianzaExperienciaAgricolaUsecase(this.repository);

  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasUsecase(UsuarioEntity usuario) {
    return repository.getAlianzasExperienciasAgricolasRepository(usuario);
  }

  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      saveAlianzasExperienciasAgricolasUsecase(
          UsuarioEntity usuario,
          List<AlianzaExperienciaAgricolaEntity>
              alianzaExperienciaAgricolaEntity) {
    return repository.saveAlianzasExperienciasAgricolasRepository(
        usuario, alianzaExperienciaAgricolaEntity);
  }
}
