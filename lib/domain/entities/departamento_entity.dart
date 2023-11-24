class DepartamentoEntity {
  DepartamentoEntity({this.id, this.nombre, this.paisId});

  String? id;
  String? nombre;
  String? paisId;

  Map<String, dynamic> toJson() =>
      {"DepartamentoId": id, "Nombre": nombre, "PaisId": paisId};
}
