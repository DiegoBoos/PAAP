import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class BeneficiarioPreinversionRepository {
  Future<Either<Failure, List<BeneficiarioPreinversionEntity>>>
      getBeneficiariosPreinversionRepository(UsuarioEntity usuario);
}
