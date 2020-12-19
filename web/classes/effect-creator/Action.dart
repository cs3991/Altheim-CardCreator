import 'ActionPlaceholder.dart';
import 'Template.dart';
import 'Type.dart';

class Action {
  /// The name of the function
  final String _name;

  /// The documentation of the function
  final String _doc;

  AbstractType _returnType;

  /// Is the function a template
  final bool _isTemplate;

  /// The map containing the templates references corresponding to
  /// the symbol used in the template declaration
  final Map<String, Template> _templates = {};

  final List<Template> _constrainedTemplates = [];

  /// The parameters of the function
  final List<ActionPlaceholder> _params = [];

  /// The placeholder that contains this action
  final ActionPlaceholder _placeholder;

  Action(Map<String, dynamic> json, this._placeholder)
      : _doc = json['doc'],
        _name = json['name'],
        _isTemplate = json['template'] != null {

    // If it is a template, create Template objects
    if (_isTemplate) {
      for (var t in json['template']) {
        _templates[t] = Template();
      }
    }

    // Create the return Type object
    _returnType = AbstractType.fromJson(json['return'], _templates);

    // Unify return type with the one from the placeholder
    _placeholder.returnType.unify(_returnType, this);

    if (_name == 'élément_actuel_prédicat') {
      var pred = placeholder.findParentPredicate().parent;
      pred.returnType.unify(_returnType, this);
    }

    // Add parameters placeholders
    for (var param in json['params']) {
      var paramPlaceholder = ActionPlaceholder.fromJson(param, _placeholder, _templates);
      _params.add(paramPlaceholder);
    }
  }

  void addConstrainedTemplate(Template template) {
    _constrainedTemplates.add(template);
  }

  void destroy() {
    _constrainedTemplates.forEach((template) {
      template.unsetInstantiation(this);
    });
    _templates.values.forEach((template) {
      template.destroy();
    });
    _params.forEach((param) {param.destroy();});
  }


  ActionPlaceholder get placeholder => _placeholder;

  List<ActionPlaceholder> get params => _params;

  Map<String, Template> get templates => _templates;

  bool get isTemplate => _isTemplate;

  AbstractType get returnType => _returnType;

  String get doc => _doc;

  String get name => _name;
}
