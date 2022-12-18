class SyncLogEntity {
  SyncLogEntity({required this.tabla, required this.cantidadRegistros});

  String tabla;
  int cantidadRegistros;

  factory SyncLogEntity.fromJson(Map<String, dynamic> json) => SyncLogEntity(
      tabla: json["Tabla"], cantidadRegistros: json["CantidadRegistros"]);

  Map<String, dynamic> toJson() =>
      {"Tabla": tabla, "CantidadRegistros": cantidadRegistros};
}
