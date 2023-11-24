class VPerfilEntity {
  VPerfilEntity({
    this.perfilId,
    this.convocatoriaId,
    this.nombre,
    this.abreviatura,
    this.municipio,
    this.departamento,
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
  });

  String? perfilId;
  String? convocatoriaId;
  String? nombre;
  String? abreviatura;
  String? municipio;
  String? departamento;
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

  Map<String, dynamic> toJson() => {
        "perfilId": perfilId,
        "convocatoriaId": convocatoriaId,
        "nombre": nombre,
        "abreviatura": abreviatura,
        "municipio": municipio,
        "departamento": departamento,
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
      };
}
