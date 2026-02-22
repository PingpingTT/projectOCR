

import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';

abstract class IdCardState {}

class IdCardInitial extends IdCardState {}

class IdCardLoading extends IdCardState {}

class IdCardSuccess extends IdCardState {
  final IdCardEntity entity;

  IdCardSuccess(this.entity);
}

class IdCardError extends IdCardState {
  final String message;

  IdCardError(this.message);
}
