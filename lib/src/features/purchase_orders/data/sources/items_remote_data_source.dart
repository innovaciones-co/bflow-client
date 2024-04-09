import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/data/models/item_model.dart';
import 'package:bflow_client/src/features/purchase_orders/data/models/purchase_order_model.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/item_entity.dart';

class ItemsRemoteDataSource extends RemoteDataSource {
  ItemsRemoteDataSource({required super.apiService});

  Future<ItemModel> fetchItem(int id) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint:
            ApiConstants.getItemEndpoint.replaceFirst(':id', id.toString()));
    return ItemModel.fromMap(response);
  }

  Future<List<ItemModel>> fetchItems() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listItemsEndpoint);
    return response.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<List<PurchaseOrderModel>> createPurchaseOrder(List<Item> items) async {
    List<dynamic> response = await apiService.post(
      endpoint: ApiConstants.createPurchaseOrderEndpoint,
      //data: itemModel.toMap(),
    );
    // TODO: implement createPurchaseOrder

    return response.map((e) => PurchaseOrderModel.fromMap(e)).toList();
  }

  Future<ItemModel> createItem(Item item) async {
    final itemModel = ItemModel.fromEntity(item);
    int itemId = await apiService.post(
      endpoint: ApiConstants.listItemsEndpoint,
      data: itemModel.toMap(),
    );

    return fetchItem(itemId);
  }

  Future<ItemModel> updateItem(Item item) async {
    final itemModel = ItemModel.fromEntity(item);
    int itemId = await apiService.put(
      endpoint:
          ApiConstants.getItemEndpoint.replaceAll(':id', item.id.toString()),
      data: itemModel.toMap(),
    );

    return fetchItem(itemId);
  }

  Future<void> deleteItem(int id) async {
    await apiService.delete(
      endpoint: ApiConstants.getItemEndpoint.replaceAll(':id', id.toString()),
    );
  }
}
