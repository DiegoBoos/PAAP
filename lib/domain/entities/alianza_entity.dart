class AlianzaEntity {
  AlianzaEntity({
    required this.alianzaId,
    required this.perfilPreInversionId,
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
    required this.legalizado,
  });

  final String alianzaId;
  final String perfilPreInversionId;
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
  final String legalizado;

  factory AlianzaEntity.fromJson(Map<String, dynamic> json) => AlianzaEntity(
        alianzaId: json["AlianzaId"],
        perfilPreInversionId: json["PerfilPreInversionId"],
        convocatoriaId: json["ConvocatoriaId"],
        nombre: json["Nombre"],
        abreviatura: json["Abreviatura"],
        nit: json["NIT"],
        municipioId: json["MunicipioId"],
        direccion: json["Direccion"],
        contacto: json["Contacto"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        tipoProyectoId: json["TipoProyectoId"],
        productoId: json["ProductoId"],
        productoAsociadoId: json["ProductoAsociadoId"],
        valorTotalProyecto: json["ValorTotalProyecto"],
        incentivoModular: json["IncentivoModular"],
        legalizado: json["Legalizado"],
      );

  Map<String, dynamic> toJson() => {
        "AlianzaId": alianzaId,
        "PerfilPreInversionId": perfilPreInversionId,
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
        "Legalizado": legalizado,
      };
}
