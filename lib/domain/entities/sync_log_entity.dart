class SyncLogEntity {
  SyncLogEntity({this.tabla, this.cantidadRegistros});

  String? tabla;
  int? cantidadRegistros;

  Map<String, dynamic> toJson() =>
      {"Tabla": tabla, "CantidadRegistros": cantidadRegistros};
}
