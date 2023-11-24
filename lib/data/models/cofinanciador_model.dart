import 'package:paap/domain/entities/cofinanciador_entity.dart';

class CofinanciadorModel extends CofinanciadorEntity {
  CofinanciadorModel({
    String? id,
    String? nombre,
    String? telefonoFijo,
    String? telefonoMovil,
    String? correo,
    String? direccion,
    String? tipoEntidad,
    String? departamento,
    String? municipio,
  }) : super(
            id: id,
            nombre: nombre,
            telefonoFijo: telefonoFijo,
            telefonoMovil: telefonoMovil,
            correo: correo,
            direccion: direccion,
            tipoEntidad: tipoEntidad,
            departamento: departamento,
            municipio: municipio);

  factory CofinanciadorModel.fromJson(Map<String, dynamic> json) =>
      CofinanciadorModel(
        id: json["ID"],
        nombre: json["Nombre"],
        telefonoFijo: json["Teléfono_x0020_Fijo"],
        telefonoMovil: json["Teléfono_x0020_Móvil"],
        correo: json["Correo"],
        direccion: json["Dirección"],
        tipoEntidad: json["Tipo_x0020_Entidad"],
        departamento: json["Departamento"],
        municipio: json["Municipio"],
      );
}
