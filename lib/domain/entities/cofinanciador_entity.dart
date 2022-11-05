class CofinanciadorEntity {
  CofinanciadorEntity({
    required this.id,
    required this.nombre,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.direccion,
    required this.tipoEntidad,
    required this.departamento,
    required this.municipio,
  });

  String id;
  String nombre;
  String telefonoFijo;
  String telefonoMovil;
  String correo;
  String direccion;
  String tipoEntidad;
  String departamento;
  String municipio;

  factory CofinanciadorEntity.fromJson(Map<String, dynamic> json) =>
      CofinanciadorEntity(
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
