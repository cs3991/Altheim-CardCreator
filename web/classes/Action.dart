import 'dart:html';
import 'ActionList.dart';

class Action {
  final String _name;

  /// The return type of the function ('T' , 'string', 'list'...)
  final String _returnType;

  /// Is the function a template
  bool _isTemplate = false;

  /// The type parameter of the return type, or null if it is not parameterized (null, 'T', int...)
  final String _returnTypeParameter;

  /// The type currently replacing the template, or null if not set yet (null, 'carte', 'int'...)
  String _templateInstanciation;

  /// The node that is at the highest level of a template dependency tree
  Action _dependencyRoot;

  final Map<Action, bool> _actionsTemplateConstrained = {};

  /// The parent and/or child that depend on the same template
  final List<Action> _templateDependencies = [];

  /// The caller of the function
  final Action _parent;

  /// The parameters of the function
  final List<Action> _params = [];

  String _functionName = '';
  String _doc = '';

  DivElement _mainDiv;
  bool _varOnly = false;
  int _varValue;

  Action(this._returnType, this._name, this._parent, {returnTypeParameter, templateInstanciation, dependencyRoot})
      : _templateInstanciation = templateInstanciation,
        _returnTypeParameter = returnTypeParameter,
        _dependencyRoot = dependencyRoot {
    // print('$_name -> $_returnType<$_templateInstanciation>');

    _mainDiv = document.createElement('div');
    _mainDiv.setAttribute('class', 'action_div');

    // Create the label with the name of the action
    var label = document.createElement('label');
    label.setAttribute('class', 'action_label');
    label.innerText = _name;
    _mainDiv.append(label);

    // Create the input if the arg has type int
    createInputIntIfNeeded();

    // Create the select representing this action
    var select = document.createElement('select');
    if (_isTemplate) {
      select.style.color = _templateInstanciation != null ? '#0f0' : '#f00';
    }
    select.setAttribute('class', 'action_select');
    _populateSelect(select);
    select.addEventListener('change', (evt) => _selectChangeCallback(_mainDiv, evt));
    _mainDiv.append(select);
  }

  void createInputIntIfNeeded() {
    _mainDiv.children.removeWhere((e) => e.classes.contains('action_int_input'));

    // Create the input if the arg has type int
    var retType = _returnType == 'T' ? _templateInstanciation : _returnType;
    // print(retType);

    if (retType == 'int') {
      var input = document.createElement('input');
      input.setAttribute('class', 'action_int_input');
      input.setAttribute('type', 'number');
      input.addEventListener('change', (evt) => _onInputChange(evt));
      _mainDiv.append(input);
    }
  }

  Map<String, dynamic> toJson() {
    if (_returnType == 'int' && _varOnly) {
      return {'int': _varValue};
    }
    return {_functionName: _params.map((e) => e.toJson()).toList()};
  }

  Action getRoot() {
    return parent == null ? this : parent.getRoot();
  }

  void _selectChangeCallback(HtmlElement div, Event evt) {
    var select = evt.target as SelectElement;
    var val = select.value;
    var action = actions.firstWhere((a) => a['name'] == val, orElse: () => null);

    // Remove previous template dependencies
    _templateDependencies.removeWhere((element) => _params.contains(element));
    _params.forEach((element) {
      element.destroy();
    });
    _params.clear();

    if (action != null) {
      if (_templateDependencies.isEmpty) {
        _updateTemplateInstanciation(null, this);
      }

      _doc = action['doc'];
      _functionName = action['name'];
      if (_dependencyRoot == null && action['template'] == 'T') {
        _dependencyRoot = this;
      }
      _isTemplate = action['template'] == 'T';
      if (_isTemplate) {
        _mainDiv.querySelector('.action_select').style.color = _templateInstanciation != null ? '#0f0' : '#f00';
      } else {
        _mainDiv.querySelector('.action_select').style.color = '#fff';
      }

      // print('$_name : $functionName -> $_returnType<$_templateInstanciation> ');

      // Instantiate template if possible
      // If it is a parameterized type
      if (_returnTypeParameter != null) {
        var actionRetTypeParameter = (action['return'] as Map<String, String>)['template'];
        if (_returnTypeParameter == 'T' && actionRetTypeParameter != 'T') {
          // ex: current returnType : list<T>, this action return type = list<int>
          // print('1 | Template instanciated to ' + actionRetTypeParameter);
          _notifyTemplateConstrained(this, true, actionRetTypeParameter);
        } else if (_returnTypeParameter != 'T' && actionRetTypeParameter == 'T') {
          // ex: current returnType : list<int>, this action return type = list<T>
          // print('2 | Template instanciated to ' + _returnTypeParameter);
          _notifyTemplateConstrained(this, true, _returnTypeParameter);
        } else {
          _notifyTemplateConstrained(this, false);
        }
      } else {
        var actionReturnType = action['return'];
        var parentPred = _findParentPredicate();

        if (_returnType == 'T' && actionReturnType != 'T') {
          // ex: current returnType : T, this action return type = int
          // print('3 | Template instanciated to ' + actionReturnType);
          _notifyTemplateConstrained(this, true, actionReturnType);
        } else if (_functionName == 'élément_actuel_prédicat' && parentPred._templateInstanciation == null) {
          // special case for the current predicate element
          // print('5 | Template instanciated to ' + parentPredType);
          parentPred._notifyTemplateConstrained(this, true, _returnType);
          _mainDiv.querySelector('.action_select').style.color = '#0f0';
        } else if (_returnType != 'T' && actionReturnType == 'T') {
          // ex: current returnType : int, this action return type : T
          // print('4 | Template instanciated to ' + _returnType);
          _notifyTemplateConstrained(this, true, _returnType);
        } else {
          _notifyTemplateConstrained(this, false);
        }
      }

      for (var param in action['params']) {
        Action newAction;
        // if the return type of the param is not parameterized
        if (param['type'].runtimeType == String) {
          if (param['type'] == 'T') {
            // If the type is T, create a dependant template action
            newAction = Action(param['type'], param['name'], this,
                templateInstanciation: _templateInstanciation, dependencyRoot: _dependencyRoot);
            _addTemplateDependency(newAction);
          } else {
            // If not T, create a normal action
            newAction = Action(param['type'], param['name'], this);
          }
        } else {
          // if it is a template
          String returnTypeParameter = param['type']['template'];
          if (returnTypeParameter == 'T') {
            // If the return type parameter is generic, create a dependant template action
            newAction = Action(param['type']['type'], param['name'], this,
                returnTypeParameter: returnTypeParameter,
                templateInstanciation: _templateInstanciation,
                dependencyRoot: _dependencyRoot);
            _addTemplateDependency(newAction);
          } else {
            // If the return template is explicitly specified, create a normal parameterized action
            newAction = Action(param['type']['type'], param['name'], this, returnTypeParameter: returnTypeParameter);
          }
        }
        _params.add(newAction);
      }
    } else {
      // if action == null

      // Special case of the current predicate element
      if (_functionName == 'élément_actuel_prédicat') {
        _findParentPredicate()._notifyTemplateConstrained(this, false);
      } else {
        _notifyTemplateConstrained(this, false);
      }
      _doc = '';
      _functionName = '';
      _varOnly = false;
      _varValue = null;
      _isTemplate = false;
    }
    _populateParamsDiv();
    // print(getRoot().toJson());
  }

  void _notifyTemplateConstrained(Action action, bool constrained, [String instantiation]) {
    if (_dependencyRoot != this && _dependencyRoot != null) {
      _dependencyRoot._notifyTemplateConstrained(action, constrained, instantiation);
    }
    _actionsTemplateConstrained[action] = constrained;
    if (!_actionsTemplateConstrained.containsValue(true)) {
      _updateTemplateInstanciation(null, this);
    } else if (constrained) {
      assert(instantiation != null);
      _updateTemplateInstanciation(instantiation, this);
    }
  }

  void _updateTemplateInstanciation(String templateInstanciation, Action caller) {
    if (_templateInstanciation == templateInstanciation) return;

    if (templateInstanciation != null && _templateInstanciation != null) {
      print('Template is already instantiated !\n'
          'Param = $name, action = $_functionName, template = $_templateInstanciation');
      assert(false);
    }

    _templateInstanciation = templateInstanciation;
    for (var dep in _templateDependencies) {
      if (dep != caller) {
        dep._updateTemplateInstanciation(templateInstanciation, this);
      }
    }
    _populateSelect(_mainDiv.querySelector('.action_select'));
    createInputIntIfNeeded();
    if (_isTemplate) {
      _mainDiv.querySelector('.action_select').style.color = _templateInstanciation != null ? '#0f0' : '#f00';
    } else {
      _mainDiv.querySelector('.action_select').style.color = '#fff';
    }
  }

  void _populateParamsDiv() {
    var paramsDiv = _mainDiv.querySelector('.action_params');

    // remove the div for param if there aren't any
    if (_params.isEmpty) {
      paramsDiv?.remove();
      return;
    }

    // Create div for params if it doesn't exist yet
    if (paramsDiv == null) {
      paramsDiv = document.createElement('div');
      paramsDiv.setAttribute('class', 'action_params');
      _mainDiv.append(paramsDiv);
    }

    paramsDiv.querySelectorAll('.action_div').forEach((element) => element.remove());
    for (var param in _params) {
      paramsDiv.append(param._mainDiv);
    }
  }

  Action _findParentPredicate() {
    return _parent == null
        ? null
        : _parent._name == 'prédicat'
            ? _parent._parent
            : _parent._findParentPredicate();
  }

  void _populateSelect(SelectElement select) {
    if (select == null) return;
    var currentValue = select.value;

    // Remove all options
    var optionsToRemove = <Element>[];
    optionsToRemove.addAll(select.children);
    optionsToRemove.forEach((element) {
      element.remove();
    });

    var filteredActions = actions.where((a) {
      String aType;
      String aReturnTypeParameter;
      if (a['return'].runtimeType == String) {
        aType = a['return'];
      } else {
        aType = (a['return'] as Map<String, String>)['type'];
        aReturnTypeParameter = (a['return'] as Map<String, String>)['template'];
      }

      if (a['name'] == 'élément_actuel_prédicat') {
        var pred = _findParentPredicate();
        return pred != null &&
            _returnTypeParameter == null &&
            (pred._templateInstanciation == null || pred._templateInstanciation == _returnType);
      }

      if ((a['params'] as List<dynamic>).isNotEmpty &&
          (a['params'] as List<Map<String, dynamic>>).indexWhere((element) => element['name'] == 'prédicat') != -1 &&
          (_name == 'prédicat' || _findParentPredicate() != null)) {
        return false;
      }

      if (_returnTypeParameter != null) {
        if (_returnTypeParameter == 'T' && _templateInstanciation == null) {
          // ex: list<T>
          return aType == _returnType && aReturnTypeParameter != null && _isEnabled(a);
        } else {
          // ex: list<carte>
          var retParam = _returnTypeParameter == 'T' ? _templateInstanciation : _returnTypeParameter;
          return aType == _returnType &&
              (aReturnTypeParameter == retParam || aReturnTypeParameter == 'T') &&
              _isEnabled(a);
        }
      } else {
        if (_returnType == 'T' && _templateInstanciation == null) {
          // ex: T
          return aReturnTypeParameter == null && _isEnabled(a);
        } else {
          // ex: int
          var retType = _returnType == 'T' ? _templateInstanciation : _returnType;
          return aReturnTypeParameter == null && (aType == retType || aType == 'T') && _isEnabled(a);
        }
      }
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

    // Create the default null option
    var defaultOption = document.createElement('option');
    defaultOption.setAttribute('class', 'action_option action_default_option');
    defaultOption.setAttribute('value', 'null');
    select.append(defaultOption);

    for (var action in actionList) {
      var option = document.createElement('option');
      option.setAttribute('value', action['name']);
      if (action['template'] == 'T') {
        option.innerText = '-- ' + action['name'] + ' --';
      } else {
        option.innerText = action['name'];
      }
      option.setAttribute('title', action['doc']);
      select.append(option);
    }

    select.value = select.options.map((e) => e.value).contains(currentValue) ? currentValue : 'null';
  }

  bool _isEnabled(Map<String, Object> action) {
    var cond = action['enable_if'];
    if (cond == null) return true;

    if (cond is Map<String, Object>) {
      var trigger = document.querySelector('#trigger_div>.action_div>.action_select') as SelectElement;
      return ((cond['trigger'] == null || (cond['trigger'] as List<String>).contains(trigger.value)) &&
          (cond['parents_param_name'] == null || _checkParentsParamNameIs(cond['parents_param_name'] as String)));
    }

    return true;
  }

  void _onInputChange(Event evt) {
    var input = evt.target as InputElement;
    if (_returnType == 'int' && input.value != '') {
      _varValue = int.tryParse(input.value);
      _varOnly = _varValue != null;
    }
  }

  void _addTemplateDependency(Action action) {
    _templateDependencies.add(action);
    action._templateDependencies.add(this);
  }

  bool _checkParentsParamNameIs(String paramName) {
    return _parent != null && (_parent._name == paramName || _parent._checkParentsParamNameIs(paramName));
  }

  void destroy() {
    if (_dependencyRoot != null) _dependencyRoot._notifyTemplateConstrained(this, false);
    _params.forEach((element) {
      element.destroy();
    });
  }

  String get name => _name;

  String get returnType => _returnType;

  Action get parent => _parent;

  String get doc => _doc;

  List<Action> get params => _params;

  DivElement get mainDiv => _mainDiv;

  String get functionName => _functionName;
}
