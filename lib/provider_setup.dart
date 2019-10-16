import 'package:provider/provider.dart';

import 'core/models/user.dart';
import 'core/services/api.dart';
import 'core/services/authentication_service.dart';
import 'core/services/storage_service.dart';

Future<Iterable<SingleChildCloneableWidget>> getProviders() async {
  var storage = await StorageService.getInstance();

  List<SingleChildCloneableWidget> independentServices = [
    Provider<StorageService>.value(value: storage),
  ];

  List<SingleChildCloneableWidget> dependentServices = [
    ProxyProvider<StorageService, Api>(
      builder: (context, storage, api) =>
        Api(storage: storage),
    ),
    ProxyProvider<Api, AuthenticationService>(
      builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
    ),
  ];

  List<SingleChildCloneableWidget> uiConsumableProviders = [
    StreamProvider<User>(
      builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
    ),
  ];

  return [
    ...independentServices,
    ...dependentServices,
    ...uiConsumableProviders
  ];
}
