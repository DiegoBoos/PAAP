class CriterioEntity {
  CriterioEntity({
    this.criterioId,
    this.nombre,
    this.descripcion,
    this.variable,
    this.valorMaximo,
    this.agrupacionId,
  });

  String? criterioId;
  String? nombre;
  String? descripcion;
  String? variable;
  String? valorMaximo;
  String? agrupacionId;

  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Variable": variable,
        "ValorMaximo": valorMaximo,
        "AgrupacionId": agrupacionId,
      };
}
