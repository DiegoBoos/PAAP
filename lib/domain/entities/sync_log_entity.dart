class SyncLogEntity {
  SyncLogEntity({required this.tabla, required this.cantidadRegistros});

  String tabla;
  int cantidadRegistros;

  Map<String, dynamic> toJson() =>
      {"Tabla": tabla, "CantidadRegistros": cantidadRegistros};
}
