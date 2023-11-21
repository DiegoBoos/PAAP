import 'package:dartz/dartz.dart';

import '../../../data/models/vereda_model.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/vereda_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class VeredaRepository {
  Future<Either<Failure, List<VeredaEntity>>> getVeredasRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<VeredaModel>>> downloadVeredas(
      UsuarioEntity usuario, List<String> municipiosIds);
}
