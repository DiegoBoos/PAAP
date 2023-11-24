class UsuarioEntity {
  UsuarioEntity({
    this.usuarioId,
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefonoFijo,
    this.telefonoMovil,
    this.correo,
    this.contrasena,
    this.fechaActivacion,
    this.fechaDesactivacion,
    this.fechaCambio,
    this.activo,
  });

  String? usuarioId;
  String? nombre;
  String? apellido;
  String? direccion;
  String? telefonoFijo;
  String? telefonoMovil;
  String? correo;
  String? contrasena;
  String? fechaActivacion;
  String? fechaDesactivacion;
  String? fechaCambio;
  String? activo;

  Map<String, dynamic> toJson() => {
        "UsuarioId": usuarioId,
        "Nombre": nombre,
        "Apellido": apellido,
        "Direccion": direccion,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "Contrasena": contrasena,
        "FechaActivacion": fechaActivacion,
        "FechaDesactivacion": fechaDesactivacion,
        "FechaCambio": fechaCambio,
        "Activo": activo
      };
}
