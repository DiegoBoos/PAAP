class PerfilEntity {
  PerfilEntity({
    this.perfilId,
    this.convocatoriaId,
    this.nombre,
    this.abreviatura,
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

  String? perfilId;
  String? convocatoriaId;
  String? nombre;
  String? abreviatura;
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

  Map<String, dynamic> toJson() => {
        "ID": perfilId,
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Abreviatura": abreviatura,
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
