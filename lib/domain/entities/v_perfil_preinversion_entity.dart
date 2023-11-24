class VPerfilPreInversionEntity {
  VPerfilPreInversionEntity({
    this.perfilPreInversionId,
    this.perfilId,
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
    this.producto,
    this.productoAsociado,
    this.valorTotalProyecto,
    this.incentivoModular,
    this.departamento,
  });

  String? perfilPreInversionId;
  String? perfilId;
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
  String? producto;
  String? productoAsociado;
  String? valorTotalProyecto;
  String? incentivoModular;
  String? departamento;

  Map<String, dynamic> toJson() => {
        "perfilPreInversionId": perfilPreInversionId,
        "perfilId": perfilId,
        "convocatoria": convocatoria,
        "nombre": nombre,
        "abreviatura": abreviatura,
        "nit": nit,
        "municipio": municipio,
        "direccion": direccion,
        "contacto": contacto,
        "telefonoFijo": telefonoFijo,
        "telefonoMovil": telefonoMovil,
        "correo": correo,
        "tipoProyecto": tipoProyecto,
        "producto": producto,
        "productoAsociado": productoAsociado,
        "valorTotalProyecto": valorTotalProyecto,
        "incentivoModular": incentivoModular,
        "departamento": departamento,
      };
}
