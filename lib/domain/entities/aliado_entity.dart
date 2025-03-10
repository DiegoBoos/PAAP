class AliadoEntity {
  AliadoEntity({
    this.aliadoId,
    this.nombre,
    this.fechaCreacion,
    this.nombreContacto,
    this.direccion,
    this.telefonoFijo,
    this.telefonoMovil,
    this.correo,
    this.municipioId,
    this.experiencia,
    this.fechaActivacion,
    this.fechaDesactivacion,
    this.fechaCambio,
    this.activo,
    this.recordStatus,
  });

  String? aliadoId;
  String? nombre;
  String? fechaCreacion;
  String? nombreContacto;
  String? direccion;
  String? telefonoFijo;
  String? telefonoMovil;
  String? correo;
  String? municipioId;
  String? experiencia;
  String? fechaActivacion;
  String? fechaDesactivacion;
  String? fechaCambio;
  String? activo;
  String? recordStatus;

  AliadoEntity copyWith({
    String? aliadoId,
    String? nombre,
    String? fechaCreacion,
    String? nombreContacto,
    String? direccion,
    String? telefonoFijo,
    String? telefonoMovil,
    String? correo,
    String? municipioId,
    String? experiencia,
    String? fechaActivacion,
    String? fechaDesactivacion,
    String? fechaCambio,
    String? activo,
    String? recordStatus,
  }) =>
      AliadoEntity(
        aliadoId: aliadoId ?? this.aliadoId,
        nombre: nombre ?? this.nombre,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        nombreContacto: nombreContacto ?? this.nombreContacto,
        direccion: direccion ?? this.direccion,
        telefonoFijo: telefonoFijo ?? this.telefonoFijo,
        telefonoMovil: telefonoMovil ?? this.telefonoMovil,
        correo: correo ?? this.correo,
        municipioId: municipioId ?? this.municipioId,
        experiencia: experiencia ?? this.experiencia,
        fechaActivacion: fechaActivacion ?? this.fechaActivacion,
        fechaDesactivacion: fechaDesactivacion ?? this.fechaDesactivacion,
        fechaCambio: fechaCambio ?? this.fechaCambio,
        activo: activo ?? this.activo,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  Map<String, dynamic> toJson() => {
        "AliadoId": aliadoId,
        "Nombre": nombre,
        "FechaCreacion": fechaCreacion,
        "NombreContacto": nombreContacto,
        "Direccion": direccion,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "MunicipioId": municipioId,
        "Experiencia": experiencia,
        "FechaActivacion": fechaActivacion,
        "FechaDesactivacion": fechaDesactivacion,
        "FechaCambio": fechaCambio,
        "Activo": activo,
        "RecordStatus": recordStatus,
      };
}
