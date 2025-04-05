import 'package:app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:app/core/shared/dto/form_dto.dart';
import 'package:app/feature/subscriptionoffers/data/models/subscription_offer_model.dart';
import 'package:flutter/widgets.dart';

abstract class SubscriptionDto extends FormDTO {
  final TextEditingController emailController;
  final EditingController<SubscriptionOfferModel>
      subscriptionOfferController;

  SubscriptionDto({
    required this.emailController,
    required this.subscriptionOfferController,
  });

  @override
  void dispose() {
    emailController.dispose();
    subscriptionOfferController.dispose();
  }
}

class CreateSubscriptionDto extends SubscriptionDto {
  CreateSubscriptionDto()
      : super(
          emailController: TextEditingController(),
          subscriptionOfferController:
              EditingController<SubscriptionOfferModel>(),
        );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'email': emailController.text,
      'offerId': subscriptionOfferController.value?.id,
    };
  }
}
