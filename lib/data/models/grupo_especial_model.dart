import 'package:paap/domain/entities/grupo_especial_entity.dart';

class GrupoEspecialModel extends GrupoEspecialEntity {
  GrupoEspecialModel({
    String? grupoEspecialId,
    String? nombre,
    String? descripcion,
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
}
