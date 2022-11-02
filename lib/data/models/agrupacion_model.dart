import 'package:paap/domain/entities/agrupacion_entity.dart';

class AgrupacionModel extends AgrupacionEntity {
  AgrupacionModel(
      {required String agrupacionId,
      required String nombre,
      required String descripcion})
      : super(
            agrupacionId: agrupacionId,
            nombre: nombre,
            descripcion: descripcion);

  factory AgrupacionModel.fromJson(Map<String, dynamic> json) =>
      AgrupacionModel(
        agrupacionId: json["AgrupacionId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "AgrupacionId": agrupacionId,
        "Nombre": nombre,
        "Descripcion": descripcion
      };
}
