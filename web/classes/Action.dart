import 'dart:html';
import 'ActionList.dart';

class Action {
  final String _name;
  final String _type;
  final Action _parent;
  String _doc = '';
  final List<Action> _params = [];
  DivElement _mainDiv;

  Action(this._type, this._name, this._parent) {
    _mainDiv = document.createElement('div');
    _mainDiv.setAttribute('class', 'action_div');

    // Create the label with the name of the action
    var label = document.createElement('label');
    label.setAttribute('class', 'action_label');
    label.innerText = _name;
    _mainDiv.append(label);

    // Create the input if the arg has type int
    if (_type == 'int') {
      var input = document.createElement('input');
      input.setAttribute('class', 'action_int_input');
      input.setAttribute('type', 'number');
      _mainDiv.append(input);
    }

    // Create the select representing this action
    var select = document.createElement('select');
    select.setAttribute('class', 'action_select');

    // Create the default null option
    var defaultOption = document.createElement('option');
    defaultOption.setAttribute('class', 'action_option action_default_option');
    defaultOption.setAttribute('value', 'null');
    select.append(defaultOption);

    _populateSelect(select);
    select.addEventListener('change', (evt) => _selectChangeCallback(_mainDiv, evt));
    _mainDiv.append(select);
  }

  void _selectChangeCallback(HtmlElement div, Event evt) {
    var select = evt.target as SelectElement;
    var val = select.value;
    var action = actions.firstWhere((a) => a['name'] == val, orElse: () => null);
    if (action != null) {
      _doc = action['doc'];
      _params.clear();
      for (var param in action['params']) {
        print('param ' + param['name'] + ' added');
        _params.add(Action(param['type'], param['name'], this));
      }
      _populateParamsDiv();
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

  void _populateSelect(Element select) {
    var filteredActions = actions.where((a) => a['return'] == _type && _isEnabled(a));

    for (var action in filteredActions) {
      var option = document.createElement('option');
      option.innerText = action['name'];
      option.setAttribute('title', action['doc']);
      select.append(option);
    }
  }

  bool _isEnabled(Map<String, Object> action) {
    var cond = action['enable_if'];
    if (cond == null) return true;

    if (cond is Map<String, List<String>>) {
      var trigger = document.querySelector('#trigger_select') as SelectElement;
      return (!(cond['declencheur'] == null) || cond['trigger'].contains(trigger.value));
    }

    return true;
  }

  String get name => _name;

  String get type => _type;

  Action get parent => _parent;

  String get doc => _doc;

  List<Action> get params => _params;

  DivElement get mainDiv => _mainDiv;
}
