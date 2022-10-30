import 'package:paap/domain/entities/unidad_entity.dart';

class UnidadModel extends UnidadEntity {
  UnidadModel(
      {required String unidadId,
      required String nombre,
      required String simbolo})
      : super(
          unidadId: unidadId,
          nombre: nombre,
          simbolo: simbolo,
        );

  factory UnidadModel.fromJson(Map<String, dynamic> json) => UnidadModel(
        unidadId: json["UnidadId"],
        nombre: json["Nombre"],
        simbolo: json["Simbolo"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "UnidadId": unidadId,
        "Nombre": nombre,
        "Simbolo": simbolo,
      };
}
