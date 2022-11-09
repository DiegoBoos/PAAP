import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_alianza_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class BeneficiarioAlianzaRepository {
  Future<Either<Failure, List<BeneficiarioAlianzaEntity>>>
      getBeneficiariosAlianzaRepository(UsuarioEntity usuario);
}
