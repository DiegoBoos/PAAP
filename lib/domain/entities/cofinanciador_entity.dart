class CofinanciadorEntity {
  CofinanciadorEntity({
    this.id,
    this.nombre,
    this.telefonoFijo,
    this.telefonoMovil,
    this.correo,
    this.direccion,
    this.tipoEntidad,
    this.departamento,
    this.municipio,
  });

  String? id;
  String? nombre;
  String? telefonoFijo;
  String? telefonoMovil;
  String? correo;
  String? direccion;
  String? tipoEntidad;
  String? departamento;
  String? municipio;

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
