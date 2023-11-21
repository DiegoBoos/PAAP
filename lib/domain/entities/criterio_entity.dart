class CriterioEntity {
  CriterioEntity({
    required this.criterioId,
    required this.nombre,
    required this.descripcion,
    required this.variable,
    required this.valorMaximo,
    required this.agrupacionId,
  });

  String criterioId;
  String nombre;
  String descripcion;
  String variable;
  String valorMaximo;
  String agrupacionId;

  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Variable": variable,
        "ValorMaximo": valorMaximo,
        "AgrupacionId": agrupacionId,
      };
}
