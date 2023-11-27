class PerfilAliadoEntity {
  PerfilAliadoEntity({
    this.perfilId,
    this.aliadoId,
    this.productoId,
    this.volumenCompra,
    this.unidadId,
    this.frecuenciaId,
    this.porcentajeCompra,
    this.sitioEntregaId,
    this.recordStatus,
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
  });

  String? perfilId;
  String? aliadoId;
  String? productoId;
  String? volumenCompra;
  String? unidadId;
  String? frecuenciaId;
  String? porcentajeCompra;
  String? sitioEntregaId;
  String? recordStatus;
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

  PerfilAliadoEntity copyWith({
    String? perfilId,
    String? aliadoId,
    String? productoId,
    String? volumenCompra,
    String? unidadId,
    String? frecuenciaId,
    String? porcentajeCompra,
    String? sitioEntregaId,
    String? aliado,
    String? recordStatus,
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
  }) =>
      PerfilAliadoEntity(
        perfilId: perfilId ?? this.perfilId,
        aliadoId: aliadoId ?? this.aliadoId,
        productoId: productoId ?? this.productoId,
        volumenCompra: volumenCompra ?? this.volumenCompra,
        unidadId: unidadId ?? this.unidadId,
        frecuenciaId: frecuenciaId ?? this.frecuenciaId,
        porcentajeCompra: porcentajeCompra ?? this.porcentajeCompra,
        sitioEntregaId: sitioEntregaId ?? this.sitioEntregaId,
        recordStatus: recordStatus ?? this.recordStatus,
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
      );

  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "AliadoId": aliadoId,
        "ProductoId": productoId,
        "VolumenCompra": volumenCompra,
        "UnidadId": unidadId,
        "FrecuenciaId": frecuenciaId,
        "PorcentajeCompra": porcentajeCompra,
        "SitioEntregaId": sitioEntregaId,
        "RecordStatus": recordStatus,
      };
}
