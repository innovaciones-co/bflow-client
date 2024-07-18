import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/catalog/data/models/category_model.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';

class CategoriesRemoteDataSource extends RemoteDataSource {
  CategoriesRemoteDataSource({required super.apiService});

  Future<CategoryModel> fetchCategory(int id) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint: ApiConstants.getCategoryEndpoint
            .replaceFirst(':id', id.toString()));
    return CategoryModel.fromMap(response);
  }

  Future<List<CategoryModel>> fetchCategories() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listCategoriesEndpoint);
    return response.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<List<CategoryModel>> fetchCategoriesBySupplier(int supplierId) async {
    List<dynamic> response = await apiService.get(
        endpoint: ApiConstants.listCategoriesEndpoint,
        params: {'supplierId': supplierId.toString()});
    return response.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<CategoryModel> createCategory(Category category) async {
    final categoryModel = CategoryModel.fromEntity(category);
    int categoryId = await apiService.post(
      endpoint: ApiConstants.listCategoriesEndpoint,
      data: categoryModel.toMap(),
    );

    return fetchCategory(categoryId);
  }

  Future<CategoryModel> updateCategory(Category category) async {
    final categoryModel = CategoryModel.fromEntity(category);
    int categoryId = await apiService.put(
      endpoint: ApiConstants.getCategoryEndpoint
          .replaceAll(':id', category.id.toString()),
      data: categoryModel.toMap(),
    );

    return fetchCategory(categoryId);
  }

  Future<void> deleteCategory(int id) async {
    await apiService.delete(
      endpoint:
          ApiConstants.getCategoryEndpoint.replaceAll(':id', id.toString()),
    );
  }
}
