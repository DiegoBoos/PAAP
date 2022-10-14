class UsuarioEntity {
  final String usuarioId;
  final String? nombre;
  final String? apellido;
  final String? direccion;
  final String? telefonoFijo;
  final String? telefonoMovil;
  final String? correo;
  final String contrasena;
  final String? fechaActivacion;
  final String? fechaDesactivacion;
  final String? fechaCambio;
  final String? activo;

  UsuarioEntity({
    required this.usuarioId,
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefonoFijo,
    this.telefonoMovil,
    this.correo,
    required this.contrasena,
    this.fechaActivacion,
    this.fechaDesactivacion,
    this.fechaCambio,
    this.activo,
  });

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) => UsuarioEntity(
        usuarioId: json["UsuarioId"],
        nombre: json["Nombre"],
        apellido: json["Apellido"],
        direccion: json["Direccion"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        contrasena: json["Contrasena"],
        fechaActivacion: json["FechaActivacion"],
        fechaDesactivacion: json["FechaDesactivacion"],
        fechaCambio: json["FechaCambio"],
        activo: json["Activo"],
      );

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
