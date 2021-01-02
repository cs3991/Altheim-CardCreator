import 'dart:html';

import 'Action.dart';
import 'ActionList.dart';
import 'ActionView.dart';
import 'Template.dart';
import 'Type.dart';

class ActionPlaceholder {
  /// The name of the action
  final String _name;

  /// The expected return type ('T' , 'string', 'list'...)
  final AbstractType _returnType;

  /// The caller of the action
  final ActionPlaceholder _parent;

  final disableTemplates;

  final ActionPlaceholder triggerPlaceholder;

  Action _action;

  ActionView _view;

  ActionPlaceholder(this._name, this._returnType, this._parent,
      {DivElement parentDiv,
      this.disableTemplates = false,
      ActionPlaceholder triggerPlaceholder})
      : triggerPlaceholder = triggerPlaceholder ?? _parent?.triggerPlaceholder {
    parentDiv ??= parent._view.paramsDiv;
    _view = ActionView(this);
    parentDiv.append(_view.mainDiv);
    _returnType.subscribeToUpdate(this);
  }

  ActionPlaceholder.fromJson(Map<String, dynamic> json,
      ActionPlaceholder parent, Map<String, Template> templates,
      [DivElement parentDiv])
      : this(json['name'], AbstractType.fromJson(json['type'], templates),
            parent,
            parentDiv: parentDiv);

  List<Map<String, dynamic>> getCompatibleActions() {
    var filteredActions = actions.where((a) {
      // Add current_element only if this placeholder is in a predicate
      if (a['name'] == 'élément_actuel_prédicat') {
        var pred = _parent?.findParentPredicate();
        return pred != null && _returnType.canUnify(pred._parent._returnType);
      }

      // Disallow adding predicate inside another predicate
      if (a['params'].isNotEmpty &&
          (a['params'] as List<Map<String, dynamic>>)
              .any((param) => param['name'] == 'prédicat') &&
          findParentPredicate() != null) {
        return false;
      }

      // Handle enable_if fields
      if (a['enable_if'] != null) {
        Map<String, List<String>> cond = a['enable_if'];
        if (cond['trigger'] != null &&
            cond['trigger'].every(
                (element) => element != triggerPlaceholder?.action?.name)) {
          return false;
        }
      }

      // Disable templates on the trigger select
      if (disableTemplates) {
        if (a['template'] != null) return false;
      }

      return _returnType
          .canUnify(AbstractType.tempFromJson(a['return'], a['template']));
    });

    var actionList = filteredActions.toList(growable: false);
    actionList.sort((a, b) {
      if (a['template'] == null) {
        if (b['template'] == null) {
          return a['name'].compareTo(b['name']);
        } else {
          return -1;
        }
      } else {
        if (b['template'] == null) {
          return 1;
        } else {
          return a['name'].compareTo(b['name']);
        }
      }
    });
    return actionList;
  }

  void setAction(Map<String, dynamic> json) {
    unsetAction();
    _action = Action(json, this);
    print(getRoot().toJson());
  }

  void unsetAction() {
    if (action != null) {
      _action.destroy();
      _action = null;
    }
  }

  void destroy() {
    _action?.destroy();
    _view.destroy();
    if (_returnType is TemplateType) {
      (_returnType as TemplateType).template.unsubscribeToUpdates(this);
    }
  }

  Action get action => _action;

  ActionPlaceholder get parent => _parent;

  AbstractType get returnType => _returnType;

  String get name => _name;

  void updateInstantiation(Template template, String typeInst) {
    _view.updateInstantiation(template, typeInst);
  }

  String toJson([int indent = 0]) {
    return (_action == null ? '{}' : _action.toJson(indent));
  }

  ActionPlaceholder findParentPredicate() {
    return _name == 'prédicat'
        ? this
        : _parent == null
            ? null
            : _parent.findParentPredicate();
  }

  ActionPlaceholder getRoot() {
    return _parent == null ? this : _parent.getRoot();
  }
}
