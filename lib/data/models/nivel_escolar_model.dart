import 'package:paap/domain/entities/nivel_escolar_entity.dart';

class NivelEscolarModel extends NivelEscolarEntity {
  NivelEscolarModel({
    required String nivelEscolarId,
    required String nombre,
    required String descripcion,
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

  @override
  Map<String, dynamic> toJson() => {
        "NivelEscolarId": nivelEscolarId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
