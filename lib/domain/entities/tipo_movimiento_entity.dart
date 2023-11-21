class TipoMovimientoEntity {
  TipoMovimientoEntity({
    required this.tipoMovimientoId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoMovimientoId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TipoMovimientoId": tipoMovimientoId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
