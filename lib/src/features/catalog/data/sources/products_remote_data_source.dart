import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/catalog/data/models/product_model.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';

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

  Future<ProductModel> fetchProduct(int productId) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint: ApiConstants.productEndpoint
            .replaceAll(':id', productId.toString()));

    return ProductModel.fromMap(response);
  }

  Future<ProductModel> createProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    int productId = await apiService.post(
      endpoint: ApiConstants.productsEndpoint,
      data: productModel.toMap(),
    );

    return fetchProduct(productId);
  }

  Future<ProductModel> updateProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    int productId = await apiService.put(
      endpoint: ApiConstants.productEndpoint
          .replaceAll(':id', productModel.id!.toString()),
      data: productModel.toMap(),
    );

    return fetchProduct(productId);
  }
}
