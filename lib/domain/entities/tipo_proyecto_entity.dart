class TipoProyectoEntity {
  TipoProyectoEntity({
    this.tipoProyectoId,
    this.nombre,
    this.descripcion,
  });

  String? tipoProyectoId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "TipoProyectoId": tipoProyectoId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
