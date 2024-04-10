import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/create_item_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_item_state.dart';

class WriteItemCubit extends Cubit<WriteItemState> {
  final ItemsBloc itemsBloc;
  final int jobId;
  final CreateItemUseCase createItemUseCase;

  WriteItemCubit({
    required this.itemsBloc,
    required this.jobId,
    required this.createItemUseCase,
  }) : super(WriteItemInitial());

  addItem(Item item) {
    createItemUseCase.execute(CreateItemParams(item: item));
    itemsBloc.add(GetItemsEvent(jobId: jobId));
  }
}
