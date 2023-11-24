import 'package:paap/domain/entities/agrupacion_entity.dart';

class AgrupacionModel extends AgrupacionEntity {
  AgrupacionModel(
      {String? agrupacionId,
      String? nombre,
      String? descripcion,
      String? convocatoriaId})
      : super(
            agrupacionId: agrupacionId,
            nombre: nombre,
            descripcion: descripcion,
            convocatoriaId: convocatoriaId);

  factory AgrupacionModel.fromJson(Map<String, dynamic> json) =>
      AgrupacionModel(
        agrupacionId: json["AgrupacionId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        convocatoriaId: json["ConvocatoriaId"],
      );
}
