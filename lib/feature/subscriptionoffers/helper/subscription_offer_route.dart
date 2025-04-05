// import 'package:app/core/router/abstract_route.dart';
// import 'package:app/feature/subscriptionoffers/data/models/subscription_offer_model.dart';
// import 'package:app/feature/subscriptionoffers/modules/multisubscriptionoffer/logic/multi_subscription_offer_cubit.dart';
// import 'package:app/feature/subscriptionoffers/modules/multisubscriptionoffer/ui/multi_subscription_offer_screen.dart';
// import 'package:app/feature/subscriptionoffers/modules/subscriptionofferform/logic/subscription_offer_form_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../modules/subscriptionofferform/ui/subscription_offer_form_screen.dart';

// class SubscriptionOfferRoute
//     extends NavigatorRouteBase<SubscriptionOfferModel> {
//   static const offersRoute = '/subscription-offers';
//   static const createOfferRoute = '/subscription-offer/create';
//   static const editOfferRoute = '/subscription-offer/edit';

//   SubscriptionOfferRoute.offers()
//       : super(
//           offersRoute,
//           child: BlocProvider(
//             lazy: false,
//             create: (_) =>
//                 MultiSubscriptionOfferCubit()..loadOffers(),
//             child: const MultiSubscriptionOfferScreen(),
//           ),
//         );

//   SubscriptionOfferRoute.create()
//       : super(
//           createOfferRoute,
//           child: BlocProvider<SubscriptionOfferFormCubit>(
//             create: (_) => CreateSubscriptionOfferCubit(),
//             child: const SubscriptionOfferFormScreen(),
//           ),
//         );

//   SubscriptionOfferRoute.edit(SubscriptionOfferModel offer)
//       : super(
//           editOfferRoute,
//           child: BlocProvider<SubscriptionOfferFormCubit>(
//             create: (_) => UpdateSubscriptionOfferCubit(offer),
//             child: const SubscriptionOfferFormScreen(),
//           ),
//         );
// }
