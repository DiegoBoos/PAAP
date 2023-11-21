import 'package:paap/domain/entities/opcion_entity.dart';

class OpcionModel extends OpcionEntity {
  OpcionModel(
      {required String opcionId,
      String? nombre,
      String? calificacion,
      required String criterioId})
      : super(
            opcionId: opcionId,
            nombre: nombre ?? '',
            calificacion: calificacion ?? '',
            criterioId: criterioId);

  factory OpcionModel.fromJson(Map<String, dynamic> json) => OpcionModel(
        opcionId: json["OpcionId"],
        nombre: json["Nombre"],
        calificacion: json["Calificacion"],
        criterioId: json["CriterioId"],
      );
}
