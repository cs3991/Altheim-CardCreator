import 'dart:html';
import 'Action.dart';
import 'ActionPlaceholder.dart';
import 'Template.dart';

class ActionView {
  final ActionPlaceholder _placeholder;

  DivElement _mainDiv;
  SelectElement _select;
  DivElement _paramsDiv;
  InputElement _intInput;
  SpanElement _returnTypeTxt;

  ActionView(this._placeholder) {
    _mainDiv = document.createElement('div');
    _mainDiv.setAttribute('class', 'action_div');

    // Create the label with the name of the action
    var label = document.createElement('label');
    label.setAttribute('class', 'action_label');
    label.innerText = _placeholder.name;
    _mainDiv.append(label);

    _returnTypeTxt = document.createElement('span');
    _returnTypeTxt.setAttribute('class', 'action_type');
    _updateReturnTypeTxt();
    _mainDiv.append(_returnTypeTxt);

    _intInput = document.createElement('input');
    _intInput.setAttribute('type', 'number');
    _intInput.setAttribute('class', 'action_input');
    _mainDiv.append(_intInput);
    _updateIntInputTextDisplay();

    // Create the select representing this action
    _select = document.createElement('select');
    _select.setAttribute('class', 'action_select');
    _populateSelect();
    _select.addEventListener('change', _selectChangeCallback);
    _mainDiv.append(_select);

    _paramsDiv = document.createElement('div');
    _paramsDiv.setAttribute('class', 'action_params');
    _mainDiv.append(paramsDiv);
  }

  void _populateSelect() {
    if (_select == null) return;
    var currentValue = _select.value;

    // Remove all options
    while (_select.children.isNotEmpty) {
      _select.children.first.remove();
    }

    // Create the default null option
    var defaultOption = document.createElement('option');
    defaultOption.setAttribute('class', 'action_option action_default_option');
    defaultOption.setAttribute('value', 'null');
    _select.append(defaultOption);

    for (var action in _placeholder.getCompatibleActions()) {
      var option = document.createElement('option');
      option.setAttribute('value', action['name']);
      if (action['template'] == 'T') {
        option.innerText = '-- ' + action['name'] + ' --';
      } else {
        option.innerText = action['name'];
      }
      option.setAttribute('title', action['doc']);
      _select.append(option);
    }

    _select.value = _select.options.map((e) => e.value).contains(currentValue)
        ? currentValue
        : 'null';
  }

  void _selectChangeCallback(Event evt) {
    var val = _select.value;

    _placeholder.unsetAction();

    if (val != 'null') {
      _placeholder.setAction(Action.fromActionName(val, _placeholder));
    }

    if (val == null) {
      _updateIntInputTextDisplay();
    } else {
      _intInput.style.display = 'none';
    }
  }

  DivElement get paramsDiv => _paramsDiv;

  DivElement get mainDiv => _mainDiv;

  SelectElement get select => _select;

  void destroy() {
    _mainDiv.remove();
  }

  void updateInstantiation(Template template, String typeInst) {
    _populateSelect();
    _updateReturnTypeTxt();
    _updateIntInputTextDisplay();
  }

  void _updateReturnTypeTxt() {
    _returnTypeTxt.innerText = _placeholder.returnType.toString();
  }

  void _updateIntInputTextDisplay() {
    if (_placeholder.returnType.type == 'int') {
      _intInput.style.display = 'inline';
    } else {
      _intInput.style.display = 'none';
    }
  }
}
