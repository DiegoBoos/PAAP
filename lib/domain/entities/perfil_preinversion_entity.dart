class PerfilPreInversionEntity {
  PerfilPreInversionEntity({
    required this.perfilPreInversionId,
    required this.perfilId,
    required this.convocatoriaId,
    required this.nombre,
    required this.abreviatura,
    required this.nit,
    required this.municipioId,
    required this.direccion,
    required this.contacto,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.tipoProyectoId,
    required this.productoId,
    required this.productoAsociadoId,
    required this.valorTotalProyecto,
    required this.incentivoModular,
  });

  final String perfilPreInversionId;
  final String perfilId;
  final String convocatoriaId;
  final String nombre;
  final String abreviatura;
  final String nit;
  final String municipioId;
  final String direccion;
  final String contacto;
  final String telefonoFijo;
  final String telefonoMovil;
  final String correo;
  final String tipoProyectoId;
  final String productoId;
  final String productoAsociadoId;
  final String valorTotalProyecto;
  final String incentivoModular;

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
