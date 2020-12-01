final actions = [
  {
    'name': 'ajouter_condition',
    'doc': 'Ajoute une condition à une transition',
    'params': [
      {'name': 'transition', 'type': 'transition'},
      {'name': 'condition', 'type': 'bool'}
    ],
    'return': 'void'
  },
  {
    'name': 'ajouter_mot_cle',
    'doc': 'Ajoute un mot-clé à une carte',
    'params': [
      {'name': 'carte', 'type': 'carte'},
      {'name': 'mot-clé', 'type': 'mot_clé'}
    ],
    'return': 'void'
  },
  {
    'name': 'modifier_stats',
    'doc': 'Ajoute des points de puissance et de résistance à une carte. Valeur négatives possibles.',
    'params': [
      {'name': 'carte', 'type': 'carte'},
      {'name': 'puissance', 'type': 'int'},
      {'name': 'résistance', 'type': 'int'}
    ],
    'return': 'void'
  },
  {
    'name': 'modifier_persistance',
    'doc': 'Ajoute des points de persistance. Valeur négatives possibles.',
    'params': [
      {'name': 'joueur', 'type': 'joueur'},
      {'name': 'points', 'type': 'int'},
    ],
    'return': 'void'
  },

  {
    'name': 'egal',
    'doc': 'Vrai si a est égal à b',
    'params': [
      {'name': 'a', 'type': 'int'},
      {'name': 'b', 'type': 'int'}
    ],
    'return': 'bool'
  },
  {
    'name': 'meme_carte',
    'doc': 'Vrai si les deux cartes sont identiques',
    'params': [
      {'name': 'a', 'type': 'carte'},
      {'name': 'b', 'type': 'carte'}
    ],
    'return': 'bool'
  },
  {
    'name': 'instance_de',
    'doc': 'Vrai si la carte est une instance de ce modèle de carte',
    'params': [
      {'name': 'carte', 'type': 'carte'},
      {'name': 'modèle', 'type': 'modèle_carte'}
    ],
    'return': 'bool'
  },
  {
    'name': 'superieur',
    'doc': 'Vrai si a est supérieur à b',
    'params': [
      {'name': 'a', 'type': 'int'},
      {'name': 'b', 'type': 'int'}
    ],
    'return': 'bool'
  },
  {
    'name': 'modele',
    'doc': 'Le modèle duquel la carte est une instance',
    'params': [
      {'name': 'carte', 'type': 'carte'}
    ],
    'return': 'modèle_carte'
  },
  {
    'name': 'type',
    'doc': 'Le type de la carte',
    'params': [
      {'name': 'carte', 'type': 'carte'}
    ],
    'return': 'type_carte'
  },
  {
    'name': 'sous_types',
    'doc': 'Les sous-types de la carte',
    'params': [
      {'name': 'carte', 'type': 'carte'}
    ],
    'return': 'liste_sous_types'
  },
  {
    'name': 'blessures_infligees',
    'doc': "Le nombre de blessures infligées par l'attaque. Ne peut s'utiliser que quand le déclencheur est attaque.",
    'params': [],
    'return': 'int',
    'enable_if': {
      'trigger': ['attaque']
    }
  },
  {
    'name': 'longueur_migration',
    'doc':
        "La distance parcourue par la carte durant sa migration. Ne peut s'utiliser que quand le déclencheur est migration.",
    'params': [],
    'return': 'int',
    'enable_if': {
      'trigger': ['migration']
    }
  },
  {
    'name': 'attaquant',
    'doc': "La carte qui a initié l'attaque. Ne peut s'utiliser que quand le déclencheur est attaque ou défense.",
    'params': [],
    'return': 'carte',
    'enable_if': {
      'trigger': ['attaque', 'defense']
    }
  },
  {
    'name': 'defenseur',
    'doc':
        "La carte qui a défendu l'attaque, ou rien si c'est le démiurge qui l'a subie. Ne peut s'utiliser que quand le déclencheur est défense.",
    'params': [],
    'return': 'carte',
    'enable_if': {
      'trigger': ['defense']
    }
  },
  {
    'name': 'carte_animee',
    'doc': "La carte qui est animée. Ne peut s'utiliser que quand le déclencheur est animation ou migration.",
    'params': [],
    'return': 'carte',
    'enable_if': {
      'trigger': ['animation', 'migration']
    }
  },
  {
    'name': 'cette_carte',
    'doc': "Cette carte (celle dont vous êtes en train d'éditer les effets en ce moment).",
    'params': [],
    'return': 'carte'
  },
  {'name': 'vrai', 'doc': 'vrai.', 'params': [], 'return': 'bool'},
  {'name': 'faux', 'doc': 'faux.', 'params': [], 'return': 'bool'},

  {
    'name': 'trouver_carte',
    'doc': 'La première carte satisfaisant le prédicat dans le container.',
    'params': [
      {'name': 'predicat', 'type': 'bool'},
      {'name': 'container', 'type': 'liste_de_cartes'}
    ],
    'return': 'carte'
  },
  {
    'name': 'filtrer',
    'doc': 'Une liste contenant seulement les cartes satisfaisant le prédicat.',
    'params': [
      {'name': 'predicat', 'type': 'bool'},
      {'name': 'container', 'type': 'liste_de_cartes'}
    ],
    'return': 'liste_de_cartes'
  },

  {'name': 'possesseur de la carte', 'doc': 'Joueur qui possède la carte.', 'params': [], 'return': 'joueur'},
  {'name': 'adversaire', 'doc': 'Le joueur adverse à celui qui possède cette carte.', 'params': [], 'return': 'joueur'},

  {
    'name': 'territoire',
    'doc': 'Le territoire du joueur spécifié.',
    'params': [
      {'name': 'joueur', 'type': 'joueur'}
    ],
    'return': 'liste_de_cartes'
  },
  {
    'name': 'main',
    'doc': 'La main du joueur spécifié.',
    'params': [
      {'name': 'joueur', 'type': 'joueur'}
    ],
    'return': 'liste_de_cartes'
  },
  {
    'name': 'panthéon',
    'doc': 'Le panthéon du joueur spécifié.',
    'params': [
      {'name': 'joueur', 'type': 'joueur'}
    ],
    'return': 'liste_de_cartes'
  },
  {
    'name': 'réserve',
    'doc': 'La réserve du joueur spécifié.',
    'params': [
      {'name': 'joueur', 'type': 'joueur'}
    ],
    'return': 'liste_de_cartes'
  },

  {
    'name': 'position_de',
    'doc': 'La position de la carte spécifiée.',
    'params': [
      {'name': 'carte', 'type': 'carte'}
    ],
    'return': 'position'
  },

  {
    'name': 'origine',
    'doc': "La position d'origine de la carte qui migre.",
    'params': [],
    'return': 'position',
    'enable_if': {
      'trigger': ['migration']
    }
  },
  {
    'name': 'destination',
    'doc': 'La position de destination de la carte qui migre.',
    'params': [],
    'return': 'position',
    'enable_if': {
      'trigger': ['migration']
    }
  },
  {
    'name': 'adjacent',
    'doc': 'Vrai si les 2 positions sont adjacentes.',
    'params': [
      {'name': 'a', 'type': 'position'},
      {'name': 'b', 'type': 'position'}
    ],
    'return': 'bool'
  },
  {
    'name': 'ligne',
    'doc': 'La ligne correspondant à cette position.',
    'params': [
      {'name': 'position', 'type': 'position'}
    ],
    'return': 'int'
  },
  {
    'name': 'colonne',
    'doc': 'La colonne correspondant à cette position.',
    'params': [
      {'name': 'position', 'type': 'position'}
    ],
    'return': 'int'
  },

  {
    'name': 'ajouter_effet',
    'doc': 'Ajoute un effet à une carte.',
    'params': [
      {'name': 'déclencheur', 'type': 'trigger'},
      {'name': 'condition', 'type': 'bool'},
      {'name': 'action', 'type': 'void'},
      {'name': 'carte', 'type': 'carte'},
    ],
    'return': 'void'
  },
  {
    'name': 'permanence',
    'doc': 'Déclencheur en permanence.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'migration',
    'doc': 'Déclencheur migration.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'invocation',
    'doc': 'Déclencheur invocation.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'découverte',
    'doc': 'Déclencheur découverte.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'animation',
    'doc': 'Déclencheur animation.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'attaque',
    'doc': 'Déclencheur attaque.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'defense',
    'doc': 'Déclencheur defense.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'fin_tour',
    'doc': 'Déclencheur fin de tour.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'fin_action',
    'doc': 'Déclencheur fin d\'action.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'mort',
    'doc': 'Déclencheur mort d\'une entité.',
    'params': [],
    'return': 'trigger'
  },
  {
    'name': 'effet_declenché',
    'doc': 'Déclencheur effet declenché par le joueur.',
    'params': [],
    'return': 'trigger'
  },

// Carte invoquée (pour invocation)
// Carte morte (pour mort)

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
// Carte_predicat (pour pout_tout et prédicats)

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
