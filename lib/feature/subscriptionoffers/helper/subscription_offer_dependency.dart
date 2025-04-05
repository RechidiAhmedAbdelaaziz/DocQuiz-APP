import 'package:app/core/di/container.dart';

import '../data/repository/subscription_repo.dart';
import '../data/source/subcription_offer_api.dart';

Future<void> setupSubscriptionOfferDependency() async {
  locator
      .registerLazySingleton(() => SubscriptionOfferApi(locator()));
  locator.registerLazySingleton(() => SubscriptionOfferRepo());
}
