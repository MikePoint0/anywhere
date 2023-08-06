import 'package:anywhere/core/enums/request_type.dart';
import 'package:anywhere/core/network/keys.dart';
import 'package:anywhere/core/network/network_service.dart';

class HomeService {
  final NetworkService networkService;

  HomeService({
    required this.networkService
  });

  Future<Map<String, dynamic>?> getCharacterList() async {
    return await networkService(
      requestType: RequestType.get,
      url: ApiConstants.url,
    );
  }

}