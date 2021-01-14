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
    'return': {'type': 'rien'}
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
    'name': 'list<entier>',
    'doc': '',
    'params': [],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'entier'}
      ]
    }
  },
  {
    'name': 'entier',
    'doc': '',
    'params': [],
    'return': {'type': 'entier'}
  },
  {
    'name': 'booléen',
    'doc': '',
    'params': [],
    'return': {'type': 'booléen'}
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
        'name': 'container',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      },
      {
        'name': 'prédicat',
        'type': {'type': 'booléen'}
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
    // 'enable_if': {
    //   'descendant_of': 'prédicat'
    // }
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
    'return': {'type': 'booléen'}
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
        'type': {'type': 'booléen'}
      }
    ],
    'return': {'type': 'rien'}
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
        'type': {'type': 'entier'}
      },
      {
        'name': 'résistance',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'rien'}
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
        'type': {'type': 'entier'}
      },
    ],
    'return': {'type': 'rien'}
  },

  {
    'name': 'égal',
    'doc': 'Vrai si a est égal à b',
    'template': ['T'],
    'params': [
      {
        'name': 'a',
        'type': {'type': 'T'}
      },
      {
        'name': 'b',
        'type': {'type': 'T'}
      }
    ],
    'return': {'type': 'booléen'}
  },
  {
    'name': 'instance_de',
    'doc': 'Retourne le modèle de cette carte',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      }
    ],
    'return': {'type': 'modèle'}
  },
  {
    'name': 'superieur',
    'doc': 'Vrai si a est supérieur à b',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'entier'}
      },
      {
        'name': 'b',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'booléen'}
  },
  {
    'name': 'additionner',
    'doc': 'Retourne a + b',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'entier'}
      },
      {
        'name': 'b',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'entier'}
  },
  {
    'name': 'soustraire',
    'doc': 'Retourne a - b',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'entier'}
      },
      {
        'name': 'b',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'entier'}
  },
  {
    'name': 'multiplier',
    'doc': 'Retourne a * b',
    'params': [
      {
        'name': 'a',
        'type': {'type': 'entier'}
      },
      {
        'name': 'b',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'entier'}
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
    'return': {'type': 'entier'},
    'enable_if': {
      'trigger': ['attaque']
    }
  },
  {
    'name': 'longueur_migration',
    'doc':
        "La distance parcourue par la carte durant sa migration. Ne peut s'utiliser que quand le déclencheur est migration.",
    'params': [],
    'return': {'type': 'entier'},
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
    'name': 'lieu_découvert',
    'doc':
        "La lieu qui vient d'être découvert. Ne peut s'utiliser que quand le déclencheur est découverte.",
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {
      'trigger': ['découverte']
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
    'return': {'type': 'booléen'}
  },
  {
    'name': 'faux',
    'doc': 'faux.',
    'params': [],
    'return': {'type': 'booléen'}
  },

  {
    'name': 'chercher',
    'template': ['T'],
    'doc': 'Le premier élément satisfaisant le prédicat dans la liste.',
    'params': [
      {
        'name': 'container',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      },
      {
        'name': 'prédicat',
        'type': {'type': 'booléen'}
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
        'name': 'liste',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      },
      {
        'name': 'prédicat',
        'type': {'type': 'booléen'}
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
    'return': {'type': 'booléen'}
  },
  {
    'name': 'contient_predicat',
    'template': ['T'],
    'doc':
        'Vrai si la liste contient au moins un élément satisfaisant le prédicat.',
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
        'name': 'prédicat',
        'type': {'type': 'booléen'}
      },
    ],
    'return': {'type': 'booléen'}
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
    'name': 'créatures_territoire',
    'doc': 'Les créatures sur le territoire du joueur spécifié.',
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
    'name': 'lieux_territoire',
    'doc': 'Les lieux sur le territoire du joueur spécifié.',
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
    'return': {'type': 'booléen'}
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
    'return': {'type': 'entier'}
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
    'return': {'type': 'entier'}
  },

  {
    'name': 'ajouter_effet',
    'doc': 'Ajoute un effet à une carte.',
    'params': [
      {
        'name': 'déclencheur',
        'type': {'type': 'déclencheur'}
      },
      {
        'name': 'condition',
        'type': {'type': 'booléen'}
      },
      {
        'name': 'action',
        'type': {'type': 'rien'}
      },
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
    ],
    'return': {'type': 'rien'}
  },
  {
    'name': 'permanence',
    'doc': 'Déclencheur : en permanence.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'migration',
    'doc': 'Déclencheur : migration.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'invocation',
    'doc': 'Déclencheur : invocation.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'découverte',
    'doc': 'Déclencheur : découverte.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'animation',
    'doc': 'Déclencheur : animation.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'attaque',
    'doc': 'Déclencheur : attaque.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'defense',
    'doc': 'Déclencheur : defense.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'fin_tour',
    'doc': 'Déclencheur : fin de tour.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'fin_action',
    'doc': 'Déclencheur : fin d\'action.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'mort',
    'doc': 'Déclencheur : mort d\'une entité.',
    'params': [],
    'return': {'type': 'déclencheur'}
  },
  {
    'name': 'effet_declenché',
    'doc': 'Déclencheur : effet declenché par le joueur.',
    'params': [],
    'return': {'type': 'déclencheur'}
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
  {
    'name': 'choix',
    'doc': "Afficher un choix de cartes à l'utilisateur.",
    'params': [
      {
        'name': 'titre',
        'type': {'type': 'texte'}
      },
      {
        'name': 'cartes_possible',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'carte'}
          ]
        }
      }
    ],
    'return': {'type': 'carte'},
  },
  {
    'name': 'choix_multiple',
    'doc': "Afficher un choix de cartes à l'utilisateur.",
    'params': [
      {
        'name': 'titre',
        'type': {'type': 'texte'}
      },
      {
        'name': 'cartes_possible',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'carte'}
          ]
        }
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'carte'}
      ]
    },
  },
  {
    'name': 'déplacer_carte',
    'doc': 'Déplace une carte vers une position donnée.',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'position',
        'type': {'type': 'position'}
      }
    ],
    'return': {'type': 'rien'}
  },
  {
    'name': 'infliger_blessures',
    'doc': 'Inflige des blessures à une carte.',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'nombre_blessures',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'soigner_blessures',
    'doc': "Soigne des blessures d'une carte.",
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'nombre_blessures',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'rien'},
  },

  // Mots-clés:
  {
    'name': 'mot-clé_migration',
    'doc': 'Le mot-clé migration',
    'params': [
      {
        'name': 'X',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'mot-clé'},
  },
  {
    'name': 'mot-clé_vision',
    'doc': 'Le mot-clé vision',
    'params': [
      {
        'name': 'X',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'mot-clé'},
  },
  {
    'name': 'mot-clé_égide',
    'doc': 'Le mot-clé égide',
    'params': [],
    'return': {'type': 'mot-clé'},
  },
  // {
  //   'name': 'mot-clé_jet',
  //   'doc': 'Le mot-clé jet',
  //   'params': [
  //     {
  //       'name': 'valeur',
  //       'type': {'type': 'entier'}
  //     }
  //   ],
  //   'return': {'type': 'rien'},
  // },
  // {
  //   'name': 'mot-clé_provocation',
  //   'doc': 'Le mot-clé migration',
  //   'params': [],
  //   'return': {'type': 'rien'},
  // },

  {
    'name': 'ajouter_mot-clé',
    'doc': 'Ajoute un mot-clé à une carte.',
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'mot-clé',
        'type': {'type': 'mot-clé'}
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'supprimer_mot-clé',
    'doc': "Supprime un mot-clé d'une carte.",
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'mot-clé',
        'type': {'type': 'mot-clé'}
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'cartes_adjacentes',
    'doc': 'Les cartes adjacentes à une position.',
    'params': [
      {
        'name': 'position',
        'type': {'type': 'position'}
      }
    ],
    'return': {
      'type': 'liste',
      'parameters': [
        {'type': 'carte'}
      ]
    },
  },
  // {
  //   'name': '',
  //   'doc': "Le début d'une liste.",
  //   'params': [
  //     {
  //       'name': 'position',
  //       'type': {'type': 'position'}
  //     }
  //   ],
  //   'return': {'type': 'liste', 'parameters': [{'type': 'carte'}]},
  // },

  {
    'name': 'longueur_liste',
    'doc': "La longueur d'une liste.",
    'template': ['T'],
    'params': [
      {
        'name': 'liste',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'T'}
          ]
        }
      }
    ],
    'return': {'type': 'entier'},
  },
  {
    'name': 'découvrir',
    'doc': 'Découvre un lieu.',
    'params': [
      {
        'name': 'lieu',
        'type': {
          'type': 'carte',
        }
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'retourner_face_cachée',
    'doc': 'Retourne face cachée ("recouvre") un lieu découvert.',
    'params': [
      {
        'name': 'lieu',
        'type': {
          'type': 'carte',
        }
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'ajouter_contrainte_invocation',
    'doc': "Ajoute une contrainte d'invocation à une carte.",
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'sous-type',
        'type': {'type': 'texte'}
      },
      {
        'name': 'nombre',
        'type': {'type': 'entier'}
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'transformer_carte',
    'doc': "Change une carte en une instance d'un autre modèle.",
    'params': [
      {
        'name': 'carte',
        'type': {'type': 'carte'}
      },
      {
        'name': 'modèle',
        'type': {'type': 'modèle'}
      }
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'carte_bénite-maudite',
    'doc':
        'La carte bénite ou maudite par cette carte. Ne peut être utilisé que quand la carte actuelle est un miracle.',
    'params': [],
    'return': {'type': 'carte'},
  },

  {
    'name': 'pour_toute_carte',
    'doc':
        "Applique une action à toutes les cartes d'une liste. Utilisez carte_actuelle_fonction à l'intérieur de cette fonction.",
    'params': [
      {
        'name': 'liste',
        'type': {
          'type': 'liste',
          'parameters': [
            {'type': 'carte'}
          ]
        }
      },
      {
        'name': 'fonction',
        'type': {'type': 'rien'}
      },
    ],
    'return': {'type': 'rien'},
  },
  {
    'name': 'carte_actuelle_fonction',
    'doc': 'Représente chaque carte qui va subir la fonction.',
    'params': [],
    'return': {'type': 'carte'},
    'enable_if': {'descendant_of': 'fonction'}
  },

// Mettre au dessus du deck (carte)

// Set variable
// Get variable
];
