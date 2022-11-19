class AliadoEntity {
  AliadoEntity({
    required this.aliadoId,
    required this.nombre,
    required this.fechaCreacion,
    required this.nombreContacto,
    required this.direccion,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.municipioId,
    required this.experiencia,
    required this.fechaActivacion,
    required this.fechaDesactivacion,
    required this.fechaCambio,
    required this.activo,
    required this.recordStatus,
  });

  String aliadoId;
  String nombre;
  String fechaCreacion;
  String nombreContacto;
  String direccion;
  String telefonoFijo;
  String telefonoMovil;
  String correo;
  String municipioId;
  String experiencia;
  String fechaActivacion;
  String fechaDesactivacion;
  String fechaCambio;
  String activo;
  String recordStatus;

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

  factory AliadoEntity.fromJson(Map<String, dynamic> json) => AliadoEntity(
        aliadoId: json["AliadoId"],
        nombre: json["Nombre"],
        fechaCreacion: json["FechaCreacion"],
        nombreContacto: json["NombreContacto"],
        direccion: json["Direccion"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        municipioId: json["MunicipioId"],
        experiencia: json["Experiencia"],
        fechaActivacion: json["FechaActivacion"],
        fechaDesactivacion: json["FechaDesactivacion"],
        fechaCambio: json["FechaCambio"],
        activo: json["Activo"],
        recordStatus: json["RecordStatus"],
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
