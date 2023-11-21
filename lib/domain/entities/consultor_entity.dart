class ConsultorEntity {
  ConsultorEntity({
    required this.consultorId,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.generoId,
    required this.fechaNacimiento,
    required this.fechaExpedicionDocumento,
    required this.direccion,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.experiencia,
    required this.activo,
    required this.usuarioId,
    required this.consultor,
  });

  String consultorId;
  String nombre1;
  String nombre2;
  String apellido1;
  String apellido2;
  String generoId;
  String fechaNacimiento;
  String fechaExpedicionDocumento;
  String direccion;
  String telefonoFijo;
  String telefonoMovil;
  String experiencia;
  String activo;
  String usuarioId;
  String consultor;

  Map<String, dynamic> toJson() => {
        "ConsultorId": consultorId,
        "Nombre1": nombre1,
        "Nombre2": nombre2,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "GeneroId": generoId,
        "FechaNacimiento": fechaNacimiento,
        "FechaExpedicionDocumento": fechaExpedicionDocumento,
        "Direccion": direccion,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Experiencia": experiencia,
        "Activo": activo,
        "UsuarioId": usuarioId,
        "Consultor": consultor,
      };
}
