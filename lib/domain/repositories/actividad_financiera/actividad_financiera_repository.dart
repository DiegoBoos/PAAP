import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_financiera_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ActividadFinancieraRepository {
  Future<Either<Failure, List<ActividadFinancieraEntity>>>
      getActividadesFinancierasRepository(UsuarioEntity usuario);
}
