class UnidadEntity {
  UnidadEntity({
    this.unidadId,
    this.nombre,
    this.simbolo,
  });

  String? unidadId;
  String? nombre;
  String? simbolo;

  Map<String, dynamic> toJson() => {
        "UnidadId": unidadId,
        "Nombre": nombre,
        "Simbolo": simbolo,
      };
}
