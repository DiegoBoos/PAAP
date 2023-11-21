class VPerfilEntity {
  VPerfilEntity({
    required this.perfilId,
    required this.convocatoriaId,
    required this.nombre,
    required this.abreviatura,
    required this.municipio,
    required this.departamento,
    required this.direccion,
    required this.contacto,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.tipoProyecto,
    required this.productoPrincipal,
    required this.productoAsociado,
    required this.valorTotalProyecto,
    required this.incentivoModular,
  });

  final String perfilId;
  final String convocatoriaId;
  final String nombre;
  final String abreviatura;
  final String municipio;
  final String departamento;
  final String direccion;
  final String contacto;
  final String telefonoFijo;
  final String telefonoMovil;
  final String correo;
  final String tipoProyecto;
  final String productoPrincipal;
  final String productoAsociado;
  final String valorTotalProyecto;
  final String incentivoModular;

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
