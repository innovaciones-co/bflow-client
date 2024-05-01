import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/data/models/product_model.dart';

class ProductsRemoteDataSource extends RemoteDataSource {
  ProductsRemoteDataSource({required super.apiService});

  Future<List<ProductModel>> fetchProducts(int? categoryId) async {
    List<dynamic> response = await apiService.get(
      endpoint: ApiConstants.productsEndpoint,
      params: categoryId != null
          ? {
              'categoryId': categoryId.toString(),
            }
          : null,
    );
    return response.map((e) => ProductModel.fromMap(e)).toList();
  }
}
