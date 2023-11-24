class NivelEscolarEntity {
  NivelEscolarEntity({
    this.nivelEscolarId,
    this.nombre,
    this.descripcion,
  });

  String? nivelEscolarId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "NivelEscolarId": nivelEscolarId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
