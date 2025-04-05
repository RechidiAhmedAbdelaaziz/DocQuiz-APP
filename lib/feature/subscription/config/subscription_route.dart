import 'package:app/core/router/routebase.dart';
import 'package:app/feature/subscription/modules/subscriptions/logic/subscriptions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionRoute extends DrawerRoute {
  SubscriptionRoute()
      : super(
          child: BlocProvider(
            create: (context) =>
                SubscriptionsCubit()..getSubscriptions(),
            child: Container(),
          ),
        );
}
