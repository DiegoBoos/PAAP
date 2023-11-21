class TipoProyectoEntity {
  TipoProyectoEntity({
    required this.tipoProyectoId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoProyectoId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TipoProyectoId": tipoProyectoId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
