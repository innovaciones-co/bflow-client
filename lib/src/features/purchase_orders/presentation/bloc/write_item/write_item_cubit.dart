import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'write_item_state.dart';

class WriteItemCubit extends Cubit<WriteItemState> {
  WriteItemCubit() : super(WriteItemInitial());
}
