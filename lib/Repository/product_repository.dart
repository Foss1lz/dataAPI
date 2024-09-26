import 'package:product_management/data/network/api.dart';
import 'package:product_management/data/network/network_service.dart';
import 'package:product_management/model/products/ProducResponse.dart';

class ProductRepository {
  final api = NetworkService();

  Future<ProductResponse> getAllProducts() async {
    var response = await api.getApi(Api.baseurl + Api.getAllProductsUrl);
    print(response);
    return ProductResponse.fromJson(response);
  }
}
