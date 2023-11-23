import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_cofinanciador/perfil_cofinanciador_repository.dart';

class PerfilCofinanciadorUsecase {
  final PerfilCofinanciadorRepository repository;

  PerfilCofinanciadorUsecase(this.repository);

  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilCofinanciadoresUsecase(UsuarioEntity usuario) {
    return repository.getPerfilCofinanciadoresRepository(usuario);
  }

  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      savePerfilesCofinanciadoresUsecase(UsuarioEntity usuario,
          List<PerfilCofinanciadorEntity> perfilCofinanciadorEntity) {
    return repository.savePerfilesCofinanciadoresRepository(
        usuario, perfilCofinanciadorEntity);
  }
}
