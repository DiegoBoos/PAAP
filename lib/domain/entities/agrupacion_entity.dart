class AgrupacionEntity {
  AgrupacionEntity(
      {required this.agrupacionId,
      required this.nombre,
      required this.descripcion,
      required this.convocatoriaId});

  String agrupacionId;
  String nombre;
  String descripcion;
  String convocatoriaId;

  Map<String, dynamic> toJson() => {
        "AgrupacionId": agrupacionId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "ConvocatoriaId": convocatoriaId
      };
}
