class PerfilPreInversionEntity {
  PerfilPreInversionEntity({
    this.perfilPreInversionId,
    this.perfilId,
    this.convocatoriaId,
    this.nombre,
    this.abreviatura,
    this.nit,
    this.municipioId,
    this.direccion,
    this.contacto,
    this.telefonoFijo,
    this.telefonoMovil,
    this.correo,
    this.tipoProyectoId,
    this.productoId,
    this.productoAsociadoId,
    this.valorTotalProyecto,
    this.incentivoModular,
  });

  String? perfilPreInversionId;
  String? perfilId;
  String? convocatoriaId;
  String? nombre;
  String? abreviatura;
  String? nit;
  String? municipioId;
  String? direccion;
  String? contacto;
  String? telefonoFijo;
  String? telefonoMovil;
  String? correo;
  String? tipoProyectoId;
  String? productoId;
  String? productoAsociadoId;
  String? valorTotalProyecto;
  String? incentivoModular;

  PerfilPreInversionEntity copyWith({
    String? perfilPreInversionId,
    String? perfilId,
    String? convocatoriaId,
    String? nombre,
    String? abreviatura,
    String? nit,
    String? municipioId,
    String? direccion,
    String? contacto,
    String? telefonoFijo,
    String? telefonoMovil,
    String? correo,
    String? tipoProyectoId,
    String? productoId,
    String? productoAsociadoId,
    String? valorTotalProyecto,
    String? incentivoModular,
  }) =>
      PerfilPreInversionEntity(
        perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
        perfilId: perfilId ?? this.perfilId,
        convocatoriaId: convocatoriaId ?? this.convocatoriaId,
        nombre: nombre ?? this.nombre,
        abreviatura: abreviatura ?? this.abreviatura,
        nit: nit ?? this.nit,
        municipioId: municipioId ?? this.municipioId,
        direccion: direccion ?? this.direccion,
        contacto: contacto ?? this.contacto,
        telefonoFijo: telefonoFijo ?? this.telefonoFijo,
        telefonoMovil: telefonoMovil ?? this.telefonoMovil,
        correo: correo ?? this.correo,
        tipoProyectoId: tipoProyectoId ?? this.tipoProyectoId,
        productoId: productoId ?? this.productoId,
        productoAsociadoId: productoAsociadoId ?? this.productoAsociadoId,
        valorTotalProyecto: valorTotalProyecto ?? this.valorTotalProyecto,
        incentivoModular: incentivoModular ?? this.incentivoModular,
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "PerfilId": perfilId,
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Abreviatura": abreviatura,
        "NIT": nit,
        "MunicipioId": municipioId,
        "Direccion": direccion,
        "Contacto": contacto,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "TipoProyectoId": tipoProyectoId,
        "ProductoId": productoId,
        "ProductoAsociadoId": productoAsociadoId,
        "ValorTotalProyecto": valorTotalProyecto,
        "IncentivoModular": incentivoModular,
      };
}
