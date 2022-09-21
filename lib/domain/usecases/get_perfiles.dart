import 'package:dartz/dartz.dart';
import 'package:paap/domain/repositories/api_perfiles_repository.dart';

import '../core/error/failure.dart';
import '../entities/perfil.dart';

class GetPerfiles {
  final ApiPerfilesRepository perfilesRepository;

  GetPerfiles(this.perfilesRepository);

  Future<Either<Failure, PerfilEntity>> execute() async =>
      await perfilesRepository.getPerfiles();
}
