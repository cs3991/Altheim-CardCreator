import 'dart:html';
import 'ActionPlaceholder.dart';
import 'Type.dart';

class Effect {
  ActionPlaceholder _trigger;
  ActionPlaceholder _condition;
  ActionPlaceholder _action;

  Effect(DivElement triggerDiv, DivElement conditionDiv, DivElement actionDiv) {
    _trigger = ActionPlaceholder(
      'Déclencheur',
      ExplicitType('trigger'),
      null,
      parentDiv: triggerDiv,
      disableTemplates: true,
    );

    _condition = ActionPlaceholder(
      'Condition',
      ExplicitType('bool'),
      null,
      parentDiv: conditionDiv,
      triggerPlaceholder: _trigger,
    );

    _action = ActionPlaceholder(
      'Action',
      ExplicitType('void'),
      null,
      parentDiv: actionDiv,
      triggerPlaceholder: _trigger,
    );
  }

  String toJson([int indent = 0]) {
    var lineBreak = '\n' + '  ' * indent;
    var innerLineBreak = '\n' + '  ' * (indent + 1);

    var sb = StringBuffer();
    sb.write('{');
    sb.write(innerLineBreak);
    sb.write('"declencheur": ');
    sb.write(_trigger.toJson(indent + 1));
    sb.write(',');
    sb.write(innerLineBreak);
    sb.write('"condition": ');
    sb.write(_condition.toJson(indent + 1));
    sb.write(',');
    sb.write(innerLineBreak);
    sb.write('"action": ');
    sb.write(_action.toJson(indent + 1));
    sb.write(lineBreak);
    sb.write('}');
    return sb.toString();
  }

  void fillFromJson(Map<String, dynamic> json) {
    _trigger.fillFromJson(json['declencheur']);
    _condition.fillFromJson(json['condition']);
    _action.fillFromJson(json['action']);
  }
}
