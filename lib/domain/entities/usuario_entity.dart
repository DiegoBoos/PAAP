class UsuarioEntity {
  UsuarioEntity({
    required this.usuarioId,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.contrasena,
    required this.fechaActivacion,
    required this.fechaDesactivacion,
    required this.fechaCambio,
    required this.activo,
  });

  final String usuarioId;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefonoFijo;
  final String telefonoMovil;
  final String correo;
  final String contrasena;
  final String fechaActivacion;
  final String fechaDesactivacion;
  final String fechaCambio;
  final String activo;

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
