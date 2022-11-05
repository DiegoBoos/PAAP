import 'package:paap/domain/entities/grupo_especial_entity.dart';

class GrupoEspecialModel extends GrupoEspecialEntity {
  GrupoEspecialModel({
    required String grupoEspecialId,
    required String nombre,
    required String descripcion,
  }) : super(
            grupoEspecialId: grupoEspecialId,
            nombre: nombre,
            descripcion: descripcion);

  factory GrupoEspecialModel.fromJson(Map<String, dynamic> json) =>
      GrupoEspecialModel(
        grupoEspecialId: json["GrupoEspecialId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "GrupoEspecialId": grupoEspecialId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
