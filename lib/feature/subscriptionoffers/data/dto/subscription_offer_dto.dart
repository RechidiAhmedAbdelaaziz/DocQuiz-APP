import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:app/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:app/core/shared/dto/form_dto.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';

import 'package:app/feature/subscriptionoffers/data/models/subscription_offer_model.dart';
import 'package:flutter/widgets.dart';

abstract class SubscriptionOfferDto extends FormDTO {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final EditingController<DomainModel> domainController;
  final ListEditingController<LevelModel> levelsController;

  SubscriptionOfferDto({
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.domainController,
    required this.levelsController,
  });

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    domainController.dispose();
    levelsController.dispose();
  }
}

class CreateSubscriptionOfferDto extends SubscriptionOfferDto {
  CreateSubscriptionOfferDto()
      : super(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
          priceController: TextEditingController(),
          domainController: EditingController<DomainModel>(),
          levelsController: ListEditingController<LevelModel>(),
        );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'title': titleController.text,
      'description': descriptionController.text,
      'price': int.parse(priceController.text),
      'domainId': domainController.value?.id,
      'levels': levelsController.value.map((e) => e.id).toList(),
    };
  }
}

class UpdateSubscriptionOfferDto extends SubscriptionOfferDto {
  final SubscriptionOfferModel _model;
  UpdateSubscriptionOfferDto(this._model)
      : super(
          titleController: TextEditingController(text: _model.title),
          descriptionController:
              TextEditingController(text: _model.description),
          priceController:
              TextEditingController(text: _model.price.toString()),
          domainController:
              EditingController<DomainModel>(_model.domain),
          levelsController: ListEditingController<LevelModel>(
            _model.levels,
          ),
        );

  String get id => _model.id!;

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      if (_model.title != titleController.text)
        'title': titleController.text,
      if (_model.description != descriptionController.text)
        'description': descriptionController.text,
      if (_model.price != int.parse(priceController.text))
        'price': int.parse(priceController.text),
      if (_model.domain != domainController.value)
        'domain': domainController.value?.id,
      if (!_model.levels.equals(levelsController.value))
        'levels': levelsController.value.map((e) => e.id).toList(),
    };
  }
}
