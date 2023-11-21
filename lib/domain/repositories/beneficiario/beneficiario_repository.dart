import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class BeneficiarioRepository {
  Future<Either<Failure, List<BeneficiarioEntity>>> getBeneficiariosRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<BeneficiarioEntity>>> saveBeneficiariosRepository(
      UsuarioEntity usuario, List<BeneficiarioEntity> beneficiariosEntity);
}
