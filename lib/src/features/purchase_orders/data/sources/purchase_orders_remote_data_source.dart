import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/data/models/purchase_order_model.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';

class PurchaseOrdersRemoteDataSource extends RemoteDataSource {
  PurchaseOrdersRemoteDataSource({required super.apiService});

  Future<PurchaseOrderModel> fetchPurchaseOrder(int id) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint: ApiConstants.getPurchaseOrderEndpoint
            .replaceFirst(':id', id.toString()));
    return PurchaseOrderModel.fromMap(response);
  }

  Future<List<PurchaseOrderModel>> fetchPurchaseOrders() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listPurchaseOrdersEndpoint);
    return response.map((e) => PurchaseOrderModel.fromMap(e)).toList();
  }

  Future<List<PurchaseOrderModel>> fetchPurchaseOrdersByJob(int jobId) async {
    List<dynamic> response = await apiService
        .get(endpoint: ApiConstants.listPurchaseOrdersEndpoint, params: {
      'jobId': jobId.toString(),
    });
    return response.map((e) => PurchaseOrderModel.fromMap(e)).toList();
  }

  Future<PurchaseOrderModel> sendPurchaseOrders(
      List<PurchaseOrder> purchaseOrders) async {
    final List<PurchaseOrder> purchaseOrderModel =
        purchaseOrders.map((e) => PurchaseOrderModel.fromEntity(e)).toList();
    // TODO: implement sendPurchaseOrders

    int purchaseOrderId = await apiService.post(
      endpoint: ApiConstants.listPurchaseOrdersEndpoint,
      //data: purchaseOrderModel,
    );
    return fetchPurchaseOrder(purchaseOrderId);
  }
}