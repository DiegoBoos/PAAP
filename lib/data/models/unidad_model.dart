import 'package:paap/domain/entities/unidad_entity.dart';

class UnidadModel extends UnidadEntity {
  UnidadModel({String? unidadId, String? nombre, String? simbolo})
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
}
