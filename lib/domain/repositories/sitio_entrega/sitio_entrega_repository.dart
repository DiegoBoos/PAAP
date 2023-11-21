import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/sitio_entrega_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class SitioEntregaRepository {
  Future<Either<Failure, List<SitioEntregaEntity>>> getSitiosEntregasRepository(
      UsuarioEntity usuario);
}
