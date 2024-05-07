import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/catalog/data/models/product_model.dart';

class ProductsRemoteDataSource extends RemoteDataSource {
  ProductsRemoteDataSource({required super.apiService});

  Future<List<ProductModel>> fetchProducts(
      int? categoryId, int? supplierId) async {
    Map<String, String> params = {};
    if (categoryId != null) {
      params.addAll({'categoryId': categoryId.toString()});
    }
    if (supplierId != null) {
      params.addAll({'supplierId': supplierId.toString()});
    }

    List<dynamic> response = await apiService.get(
      endpoint: ApiConstants.productsEndpoint,
      params: params,
    );
    return response.map((e) => ProductModel.fromMap(e)).toList();
  }
}
