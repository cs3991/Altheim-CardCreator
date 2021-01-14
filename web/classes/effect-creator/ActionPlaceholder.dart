import 'dart:html';

import 'Action.dart';
import 'ActionList.dart';
import 'ActionView.dart';
import 'Template.dart';
import 'Type.dart';

class ActionPlaceholder {
  /// The name of the action
  final String _name;

  /// The expected return type ('T' , 'texte', 'liste'...)
  final AbstractType _returnType;

  /// The caller of the action
  final ActionPlaceholder _parent;

  final bool disableTemplates;

  final ActionPlaceholder triggerPlaceholder;

  bool _isRawValue = false;
  int _intRawValue;
  String _strRawValue;

  Action _action;

  ActionView _view;

  ActionPlaceholder(this._name, this._returnType, this._parent,
      {DivElement parentDiv,
      this.disableTemplates = false,
      ActionPlaceholder triggerPlaceholder})
      : triggerPlaceholder = triggerPlaceholder ?? _parent?.triggerPlaceholder {
    parentDiv ??= parent?._view?.paramsDiv;
    if (parentDiv != null) {
      _view = ActionView(this, parentDiv);
    }
    _returnType.subscribeToUpdate(this);
  }

  ActionPlaceholder.fromActionList(Map<String, dynamic> json,
      ActionPlaceholder parent, Map<String, Template> templates,
      [DivElement parentDiv])
      : this(json['name'], AbstractType.fromJson(json['type'], templates),
            parent,
            parentDiv: parentDiv);

  List<Map<String, dynamic>> getCompatibleActions() {
    var filteredActions = actions.where((a) {
      // Add current_element only if this placeholder is in a predicate
      if (a['name'] == 'élément_actuel_prédicat') {
        var pred = _parent?.findParentWithName('prédicat');
        // Check if the placeholder can be unified with the type of the elements of the list
        return pred != null &&
            _returnType.canUnify(
                pred._parent._action.params[0]._returnType.typeParameters[0]);
      }

      // Disallow adding predicate inside another predicate
      if (a['params'].isNotEmpty &&
          (a['params'] as List<Map<String, dynamic>>)
              .any((param) => param['name'] == 'prédicat') &&
          findParentWithName('prédicat') != null) {
        return false;
      }

      // Disallow adding for_all inside another for_all
      if (a['params'].isNotEmpty &&
          (a['params'] as List<Map<String, dynamic>>)
              .any((param) => param['name'] == 'fonction') &&
          findParentWithName('fonction') != null) {
        return false;
      }

      // Handle enable_if fields
      if (a['enable_if'] != null) {
        Map<String, dynamic> cond = a['enable_if'];
        if (cond['trigger'] != null &&
            cond['trigger'].every(
                (element) => element != triggerPlaceholder?.action?.name)) {
          return false;
        }
        if (cond['descendant_of'] != null &&
            _parent?.findParentWithName(cond['descendant_of']) == null) {
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

  void setAction(Action action, {bool updateView = false}) {
    unsetAction();
    _isRawValue = false;
    _action = action;
    if (updateView && _view != null) {
      _view.select.value = action.name;
    }
    // print(getRoot().toJson());
  }

  void setRawValue(dynamic val, {bool updateView = false}) {
    unsetAction();
    _isRawValue = true;

    if (val is String) {
      _strRawValue = val;
      if (updateView && _view != null) {
        _view.stringInput.value = val;
      }
    } else if (val is int) {
      _intRawValue = val;
      if (updateView && _view != null) {
        _view.intInput.value = val.toString();
      }
    }
  }

  void unsetAction() {
    if (action != null) {
      _action.destroy();
      _action = null;
    }
  }

  void destroy() {
    _action?.destroy();
    _view?.destroy();
    if (_returnType is TemplateType) {
      (_returnType as TemplateType).template.unsubscribeToUpdates(this);
    }
  }

  void updateInstantiation(Template template, String typeInst) {
    _view?.updateInstantiation(template, typeInst);
  }

  dynamic toJson() {
    if (_isRawValue) {
      if (_returnType.type == 'entier') {
        return _intRawValue;
      } else if (_returnType.type == 'texte') {
        return _strRawValue;
      }
    } else {
      if (_action != null) {
        return _action.toJson();
      }
    }
    return <String, dynamic>{};
  }

  void fillFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      setAction(Action.fromJsonExport(json, this), updateView: true);
    } else {
      setRawValue(json, updateView: true);
    }
  }

  ActionPlaceholder findParentWithName(String name) {
    return _name == name
        ? this
        : _parent == null
            ? null
            : _parent.findParentWithName(name);
  }

  ActionPlaceholder getRoot() {
    return _parent == null ? this : _parent.getRoot();
  }

  void attachView(DivElement div) {
    _view?.destroy();
    _view = ActionView(this, div);
  }

  void detachView() {
    _view?.destroy();
    _view = null;
  }

  Action get action => _action;

  ActionPlaceholder get parent => _parent;

  AbstractType get returnType => _returnType;

  String get name => _name;

  bool get isRawValue => _isRawValue;

  int get intRawValue => _intRawValue;

  String get strRawValue => _strRawValue;
}
