final List<Map<String, dynamic>> actionsTest = [
  {
    'name': 'param T',
    'template': ['T'],
    'doc': '',
    'params': [
      {
        'name': 't1',
        'type': {'type': 'T'}
      },
      {
        'name': 't2',
        'type': {'type': 'T'}
      },
    ],
    'return': {'type': 'void'}
  },
  {
    'name': 'T param T',
    'template': ['T'],
    'doc': '',
    'params': [
      {
        'name': 't1',
        'type': {'type': 'T'}
      },
    ],
    'return': {'type': 'T'}
  },
  {
    'name': 'list<T> param T',
    'template': ['T'],
    'doc': '',
    'params': [
      {
        'name': 't1',
        'type': {'type': 'T'}
      },
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'T'}
      ]
    }
  },
  {
    'name': 'T param list<T>',
    'template': ['T'],
    'doc': '',
    'params': [
      {
        'name': 't1',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      },
    ],
    'return': {'type': 'T'}
  },
  {
    'name': 'list<int>',
    'doc': '',
    'params': [],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'int'}
      ]
    }
  },
  {
    'name': 'int',
    'doc': '',
    'params': [],
    'return': {'type': 'int'}
  },
  {
    'name': 'bool',
    'doc': '',
    'params': [],
    'return': {'type': 'bool'}
  },
  {
    'name': 'T',
    'template': ['T'],
    'doc': '',
    'params': [],
    'return': {'type': 'T'}
  },
  {
    'name': 'chercher',
    'template': ['T'],
    'doc': 'Le premier élément satisfaisant le prédicat dans la liste.',
    'params': [
      {
        'name': 'prédicat',
        'type': {'type': 'bool'}
      },
      {
        'name': 'container',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      }
    ],
    'return': {'type': 'T'}
  },
  {
    'name': 'élément_actuel_prédicat',
    'template': ['T'],
    'doc': 'L\'élément à tester pour le prédicat.',
    'params': [],
    'return': {'type': 'T'},
  },
  {
    'name': 'contient',
    'template': ['T'],
    'doc': 'Vrai si la liste contient l\'élément.',
    'params': [
      {
        'name': 'liste',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      },
      {
        'name': 'élement',
        'type': {'type': 'T'}
      },
    ],
    'return': {'type': 'bool'}
  },
];

final List<Map<String, dynamic>> actions = [
  {
    'name': 'ajouter_condition',
    'doc': 'Ajoute une condition à une transition',
    'params': [
      {
        'name': 'transition',
        'type': {'type': 'transition'}
      },
      {
        'name': 'condition',
        'type': {'type': 'bool'}
      }
    ],
    'return': {'type': 'void'}
  },
  {
    'name': 'ajouter_mot_cle',
    'doc': 'Ajoute un mot-clé à une carte',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'mot-clé',
        'type': {'type': 'mot_clé'}
      }
    ],
    'return': {'type': 'void'}
  },
  {
    'name': 'modifier_stats',
    'doc':
        'Ajoute des points de puissance et de résistance à une carte. Valeur négatives possibles.',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'puissance',
        'type': {'type': 'int'}
      },
      {
        'name': 'résistance',
        'type': {'type': 'int'}
      }
    ],
    'return': {'type': 'void'}
  },
  {
    'name': 'modifier_persistance',
    'doc': 'Ajoute des points de persistance. Valeur négatives possibles.',
    'params': [
      {
        'name': 'joueur',
        'type': {'type': 'joueur'}
      },
      {
        'name': 'points',
        'type': {'type': 'int'}
      },
    ],
    'return': {'type': 'void'}
  },

  {
    'name': 'egal',
    'doc': 'Vrai si a est égal à b',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'int'}
      },
      {
        'name': 'b',
        'type': {'type': 'int'}
      }
    ],
    'return': {'type': 'bool'}
  },
  {
    'name': 'meme_carte',
    'doc': 'Vrai si les deux cartes sont identiques',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'carte'}
      },
      {
        'name': 'b',
        'type': {'type': 'carte'}
      }
    ],
    'return': {'type': 'bool'}
  },
  {
    'name': 'instance_de',
    'doc': 'Vrai si la carte est une instance de ce modèle de carte',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'modèle',
        'type': {'type': 'modèle_carte'}
      }
    ],
    'return': {'type': 'bool'}
  },
  {
    'name': 'superieur',
    'doc': 'Vrai si a est supérieur à b',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'int'}
      },
      {
        'name': 'b',
        'type': {'type': 'int'}
      }
    ],
    'return': {'type': 'bool'}
  },
  {
    'name': 'modele',
    'doc': 'Le modèle duquel la carte est une instance',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      }
    ],
    'return': {'type': 'modèle_carte'}
  },
  {
    'name': 'type',
    'doc': 'Le type de la carte',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      }
    ],
    'return': {'type': 'type_carte'}
  },
  {
    'name': 'sous_types',
    'doc': 'Les sous-types de la carte',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      }
    ],
    'return': {'type': 'liste_sous_types'}
  },
  {
    'name': 'blessures_infligees',
    'doc':
        "Le nombre de blessures infligées par l'attaque. Ne peut s'utiliser que quand le déclencheur est attaque.",
    'params': [],
    'return': {'type': 'int'},
    'enable_if': {
      'trigger': ['attaque']
    }
  },
  {
    'name': 'longueur_migration',
    'doc':
        "La distance parcourue par la carte durant sa migration. Ne peut s'utiliser que quand le déclencheur est migration.",
    'params': [],
    'return': {'type': 'int'},
    'enable_if': {
      'trigger': ['migration']
    }
  },
  {
    'name': 'attaquant',
    'doc':
        "La carte qui a initié l'attaque. Ne peut s'utiliser que quand le déclencheur est attaque ou défense.",
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {
      'trigger': ['attaque', 'defense']
    }
  },
  {
    'name': 'defenseur',
    'doc':
        "La carte qui a défendu l'attaque, ou rien si c'est le démiurge qui l'a subie. Ne peut s'utiliser que quand le déclencheur est défense.",
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {
      'trigger': ['defense']
    }
  },
  {
    'name': 'carte_animee',
    'doc':
        "La carte qui est animée. Ne peut s'utiliser que quand le déclencheur est animation ou migration.",
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {
      'trigger': ['animation', 'migration']
    }
  },
  {
    'name': 'cette_carte',
    'doc':
        "Cette carte (celle dont vous êtes en train d'éditer les effets en ce moment).",
    'params': [],
    'return': {'type': 'carte'}
  },
  {
    'name': 'vrai',
    'doc': 'vrai.',
    'params': [],
    'return': {'type': 'bool'}
  },
  {
    'name': 'faux',
    'doc': 'faux.',
    'params': [],
    'return': {'type': 'bool'}
  },

  {
    'name': 'chercher',
    'template': ['T'],
    'doc': 'Le premier élément satisfaisant le prédicat dans la liste.',
    'params': [
      {
        'name': 'prédicat',
        'type': {'type': 'bool'}
      },
      {
        'name': 'container',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      }
    ],
    'return': {'type': 'T'}
  },
  {
    'name': 'filtrer',
    'template': ['T'],
    'doc':
        'Une liste contenant seulement les éléments satisfaisant le prédicat.',
    'params': [
      {
        'name': 'prédicat',
        'type': {'type': 'bool'}
      },
      {
        'name': 'container',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'T'}
      ]
    }
  },
  {
    'name': 'élément_actuel_prédicat',
    'template': ['T'],
    'doc': 'L\'élément à tester pour le prédicat.',
    'params': [],
    'return': {'type': 'T'},
  },

  {
    'name': 'contient',
    'template': ['T'],
    'doc': 'Vrai si la liste contient l\'élément.',
    'params': [
      {
        'name': 'liste',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      },
      {
        'name': 'élement',
        'type': {'type': 'T'}
      },
    ],
    'return': {'type': 'bool'}
  },

  {
    'name': 'possesseur de la carte',
    'doc': 'Joueur qui possède la carte.',
    'params': [],
    'return': {'type': 'joueur'}
  },
  {
    'name': 'adversaire',
    'doc': 'Le joueur adverse à celui qui possède cette carte.',
    'params': [],
    'return': {'type': 'joueur'}
  },

  {
    'name': 'territoire',
    'doc': 'Le territoire du joueur spécifié.',
    'params': [
      {
        'name': 'joueur',
        'type': {'type': 'joueur'}
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'carte'}
      ]
    }
  },
  {
    'name': 'main',
    'doc': 'La main du joueur spécifié.',
    'params': [
      {
        'name': 'joueur',
        'type': {'type': 'joueur'}
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'carte'}
      ]
    }
  },
  {
    'name': 'panthéon',
    'doc': 'Le panthéon du joueur spécifié.',
    'params': [
      {
        'name': 'joueur',
        'type': {'type': 'joueur'}
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'carte'}
      ]
    }
  },
  {
    'name': 'réserve',
    'doc': 'La réserve du joueur spécifié.',
    'params': [
      {
        'name': 'joueur',
        'type': {'type': 'joueur'}
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'carte'}
      ]
    }
  },

  {
    'name': 'position_de',
    'doc': 'La position de la carte spécifiée.',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      }
    ],
    'return': {'type': 'position'}
  },

  {
    'name': 'origine',
    'doc': "La position d'origine de la carte qui migre.",
    'params': [],
    'return': {'type': 'position'},
    'enable_if': {
      'trigger': ['migration']
    }
  },
  {
    'name': 'destination',
    'doc': 'La position de destination de la carte qui migre.',
    'params': [],
    'return': {'type': 'position'},
    'enable_if': {
      'trigger': ['migration']
    }
  },
  {
    'name': 'adjacent',
    'doc': 'Vrai si les 2 positions sont adjacentes.',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'position'}
      },
      {
        'name': 'b',
        'type': {'type': 'position'}
      }
    ],
    'return': {'type': 'bool'}
  },
  {
    'name': 'ligne',
    'doc': 'La ligne correspondant à cette position.',
    'params': [
      {
        'name': 'position',
        'type': {'type': 'position'}
      }
    ],
    'return': {'type': 'int'}
  },
  {
    'name': 'colonne',
    'doc': 'La colonne correspondant à cette position.',
    'params': [
      {
        'name': 'position',
        'type': {'type': 'position'}
      }
    ],
    'return': {'type': 'int'}
  },

  {
    'name': 'ajouter_effet',
    'doc': 'Ajoute un effet à une carte.',
    'params': [
      {
        'name': 'déclencheur',
        'type': {'type': 'trigger'}
      },
      {
        'name': 'condition',
        'type': {'type': 'bool'}
      },
      {
        'name': 'action',
        'type': {'type': 'void'}
      },
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
    ],
    'return': {'type': 'void'}
  },
  {
    'name': 'permanence',
    'doc': 'Déclencheur : en permanence.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'migration',
    'doc': 'Déclencheur : migration.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'invocation',
    'doc': 'Déclencheur : invocation.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'découverte',
    'doc': 'Déclencheur : découverte.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'animation',
    'doc': 'Déclencheur : animation.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'attaque',
    'doc': 'Déclencheur : attaque.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'defense',
    'doc': 'Déclencheur : defense.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'fin_tour',
    'doc': 'Déclencheur : fin de tour.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'fin_action',
    'doc': 'Déclencheur : fin d\'action.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'mort',
    'doc': 'Déclencheur : mort d\'une entité.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'effet_declenché',
    'doc': 'Déclencheur : effet declenché par le joueur.',
    'params': [],
    'return': {'type': 'trigger'}
  },
  {
    'name': 'carte_invoquée',
    'doc':
        'Carte invoquée. Disponible uniquement si le déclencheur est invocation.',
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {
      'trigger': ['invocation']
    }
  },
  {
    'name': 'carte_morte',
    'doc':
        'Carte qui vient de mourir. Disponible uniquement si le déclencheur est mort.',
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {
      'trigger': ['mort']
    }
  },

// Choix (liste_de_cartes, titre du choix -> carte)
// Choix (liste_de_cartes, titre du choix -> liste_de_cartes)

// Déplacer (carte, container)

// Infliger blessure
// soigner blessure

// Modifier mot-clé (+ ou - x, pour mot-clés avec valeur)
// Cartes adjacentes -> liste_de_cartes
// Contient_carte (liste_de_cartes, prédicat)
// Mettre au dessus du deck (carte)

// Liste_cartes_dans_container (container)
// Transformer_carte (carte, modele)
// Compter (liste, prédicat) -> int
// pour_tout (liste_de_carte, void)
// Longueur_liste (liste)
// Carte_prédicat (pour pout_tout et prédicats)

// Carte_bénie/maudite (miracle)
// lieu_découvert (pour découverte)
// lieu (carte) (lieu sur lequel est la carte)
// entité(s) sur lieu (lieu)
// Découvrir (lieu)
// Retourner (lieu)

// Ajouter_contraintes (carte, sous-type, int)

// Set variable
// Get variable
];
