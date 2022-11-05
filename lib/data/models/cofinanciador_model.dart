import 'package:paap/domain/entities/cofinanciador_entity.dart';

class CofinanciadorModel extends CofinanciadorEntity {
  CofinanciadorModel({
    required String id,
    required String nombre,
    required String telefonoFijo,
    required String telefonoMovil,
    required String correo,
    required String direccion,
    required String tipoEntidad,
    required String departamento,
    required String municipio,
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

  @override
  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
        "Teléfono_x0020_Fijo": telefonoFijo,
        "Teléfono_x0020_Móvil": telefonoMovil,
        "Correo": correo,
        "Dirección": direccion,
        "Tipo_x0020_Entidad": tipoEntidad,
        "Departamento": departamento,
        "Municipio": municipio,
      };
}
