part of 'perfil_preinversion_cubit.dart';

abstract class PerfilPreInversionState extends Equatable {
  final PerfilPreInversionEntity? perfilPreInversion;
  const PerfilPreInversionState({this.perfilPreInversion});

  @override
  List<Object?> get props => [perfilPreInversion];
}

class PerfilPreInversionInitial extends PerfilPreInversionState {
  PerfilPreInversionInitial()
      : super(
            perfilPreInversion: PerfilPreInversionEntity(
                perfilPreInversionId: '',
                perfilId: '',
                convocatoriaId: '',
                nombre: '',
                abreviatura: '',
                nit: '',
                municipioId: '',
                direccion: '',
                contacto: '',
                telefonoFijo: '',
                telefonoMovil: '',
                correo: '',
                tipoProyectoId: '',
                productoId: '',
                productoAsociadoId: '',
                valorTotalProyecto: '',
                incentivoModular: ''));
}

class PerfilPreInversionLoading extends PerfilPreInversionState {}

class PerfilPreInversionLoaded extends PerfilPreInversionState {
  final PerfilPreInversionEntity? perfilPreInversionLoaded;

  const PerfilPreInversionLoaded(this.perfilPreInversionLoaded)
      : super(perfilPreInversion: perfilPreInversionLoaded);
}

class PerfilPreInversionError extends PerfilPreInversionState {
  final String message;

  const PerfilPreInversionError(this.message);

  @override
  List<Object?> get props => [message];
}
