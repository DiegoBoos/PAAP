import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/revision_entity.dart';
import '../../usecases/revision/revision_db_usecase.dart';

part 'revision_state.dart';

class RevisionCubit extends Cubit<RevisionState> {
  final RevisionUsecaseDB revisionDB;

  RevisionCubit({required this.revisionDB}) : super(RevisionesInitial()) {
    getRevisionesDB();
  }

  void getRevisionesDB() async {
    final result = await revisionDB.getRevisionesUsecaseDB();
    result.fold((failure) => emit(RevisionesError(failure.properties.first)),
        (data) => emit(RevisionesLoaded(data)));
  }
}
