class AlianzaEntity {
  AlianzaEntity({
    this.alianzaId,
    this.perfilPreInversionId,
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
    this.legalizado,
  });

  String? alianzaId;
  String? perfilPreInversionId;
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
  String? legalizado;

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
