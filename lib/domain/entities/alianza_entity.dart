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
