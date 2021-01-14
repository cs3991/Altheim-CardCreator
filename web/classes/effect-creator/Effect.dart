import 'dart:html';

import 'ActionPlaceholder.dart';
import 'Type.dart';

class Effect {
  ActionPlaceholder _trigger;
  ActionPlaceholder _condition;
  ActionPlaceholder _action;

  Effect.fromJson(Map<String, dynamic> json) {
    _trigger = ActionPlaceholder(
      'Déclencheur',
      ExplicitType('déclencheur'),
      null,
      disableTemplates: true,
    );

    _condition = ActionPlaceholder(
      'Condition',
      ExplicitType('booléen'),
      null,
      triggerPlaceholder: _trigger,
    );

    _action = ActionPlaceholder(
      'Action',
      ExplicitType('rien'),
      null,
      triggerPlaceholder: _trigger,
    );

    _trigger.fillFromJson(json['declencheur']);
    _condition.fillFromJson(json['condition']);
    _action.fillFromJson(json['action']);
  }

  Effect(
      [DivElement triggerDiv, DivElement conditionDiv, DivElement actionDiv]) {
    _trigger = ActionPlaceholder(
      'Déclencheur',
      ExplicitType('déclencheur'),
      null,
      parentDiv: triggerDiv,
      disableTemplates: true,
    );

    _condition = ActionPlaceholder(
      'Condition',
      ExplicitType('booléen'),
      null,
      parentDiv: conditionDiv,
      triggerPlaceholder: _trigger,
    );

    _action = ActionPlaceholder(
      'Action',
      ExplicitType('rien'),
      null,
      parentDiv: actionDiv,
      triggerPlaceholder: _trigger,
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['declencheur'] = _trigger.toJson();
    json['condition'] = _condition.toJson();
    json['action'] = _action.toJson();
    return json;
  }

  void attachView(
      DivElement triggerDiv, DivElement conditionDiv, DivElement actionDiv) {
    _trigger.attachView(triggerDiv);
    _condition.attachView(conditionDiv);
    _action.attachView(actionDiv);
  }

  void detachView() {
    _trigger.detachView();
    _condition.detachView();
    _action.detachView();
  }
}
