class ConsultorEntity {
  ConsultorEntity({
    this.consultorId,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.generoId,
    this.fechaNacimiento,
    this.fechaExpedicionDocumento,
    this.direccion,
    this.telefonoFijo,
    this.telefonoMovil,
    this.experiencia,
    this.activo,
    this.usuarioId,
    this.consultor,
  });

  String? consultorId;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? generoId;
  String? fechaNacimiento;
  String? fechaExpedicionDocumento;
  String? direccion;
  String? telefonoFijo;
  String? telefonoMovil;
  String? experiencia;
  String? activo;
  String? usuarioId;
  String? consultor;

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
