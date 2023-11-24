class VAlianzaEntity {
  VAlianzaEntity(
      {this.alianzaId,
      this.perfilPreInversionId,
      this.convocatoria,
      this.nombre,
      this.abreviatura,
      this.nit,
      this.municipio,
      this.direccion,
      this.contacto,
      this.telefonoFijo,
      this.telefonoMovil,
      this.correo,
      this.tipoProyecto,
      this.productoPrincipal,
      this.productoAsociado,
      this.valorTotalProyecto,
      this.incentivoModular,
      this.legalizado});

  String? alianzaId;
  String? perfilPreInversionId;
  String? convocatoria;
  String? nombre;
  String? abreviatura;
  String? nit;
  String? municipio;
  String? direccion;
  String? contacto;
  String? telefonoFijo;
  String? telefonoMovil;
  String? correo;
  String? tipoProyecto;
  String? productoPrincipal;
  String? productoAsociado;
  String? valorTotalProyecto;
  String? incentivoModular;
  String? legalizado;

  Map<String, dynamic> toJson() => {
        "alianzaId": alianzaId,
        "perfilPreInversionId": perfilPreInversionId,
        "convocatoria": convocatoria,
        "nombre": nombre,
        "abreviatura": abreviatura,
        "municipio": municipio,
        "direccion": direccion,
        "contacto": contacto,
        "telefonoFijo": telefonoFijo,
        "telefonoMovil": telefonoMovil,
        "correo": correo,
        "tipoProyecto": tipoProyecto,
        "productoPrincipal": productoPrincipal,
        "productoAsociado": productoAsociado,
        "valorTotalProyecto": valorTotalProyecto,
        "incentivoModular": incentivoModular,
        "legalizado": legalizado,
      };
}
