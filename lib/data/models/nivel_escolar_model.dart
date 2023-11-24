import 'package:paap/domain/entities/nivel_escolar_entity.dart';

class NivelEscolarModel extends NivelEscolarEntity {
  NivelEscolarModel({
    String? nivelEscolarId,
    String? nombre,
    String? descripcion,
  }) : super(
            nivelEscolarId: nivelEscolarId,
            nombre: nombre,
            descripcion: descripcion);

  factory NivelEscolarModel.fromJson(Map<String, dynamic> json) =>
      NivelEscolarModel(
        nivelEscolarId: json["NivelEscolarId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
