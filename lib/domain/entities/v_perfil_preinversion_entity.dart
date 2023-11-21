class VPerfilPreInversionEntity {
  VPerfilPreInversionEntity({
    required this.perfilPreInversionId,
    required this.perfilId,
    required this.convocatoria,
    required this.nombre,
    required this.abreviatura,
    required this.nit,
    required this.municipio,
    required this.direccion,
    required this.contacto,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.tipoProyecto,
    required this.producto,
    required this.productoAsociado,
    required this.valorTotalProyecto,
    required this.incentivoModular,
    required this.departamento,
  });

  final String perfilPreInversionId;
  final String perfilId;
  final String convocatoria;
  final String nombre;
  final String abreviatura;
  final String nit;
  final String municipio;
  final String direccion;
  final String contacto;
  final String telefonoFijo;
  final String telefonoMovil;
  final String correo;
  final String tipoProyecto;
  final String producto;
  final String productoAsociado;
  final String valorTotalProyecto;
  final String incentivoModular;
  final String departamento;

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
