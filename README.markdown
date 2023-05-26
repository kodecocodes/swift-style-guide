# Le Guide de style officiel d'Agendrix Swift.
### Mis à jour pour Swift 5

Ce guide de style est différent des autres que vous pouvez voir, car l'accent est mis sur la lisibilité pour l'impression et le web. Nous avons créé ce guide de style pour maintenir la cohérence du code dans nos livres, tutoriels et kits de démarrage, même si nous avons de nombreux auteurs différents travaillant sur les livres.

Nos objectifs globaux sont la clarté, la cohérence et la brièveté, dans cet ordre.

## Table des matières

* [Correction](#correction)
* [Utilisation de SwiftLint](#utilisation-de-swiftlint)
* [Nommage](#nommage)
  * [Prose](#prose)
  * [Délégués](#délégués)
  * [Utilisation du contexte inféré par le type](#utiliser-le-contexte-dinférence-de-type)
  * [Génériques](#génériques)
  * [Préfixes de classe](#préfixes-de-classe)
  * [Langue](#langue)
* [Organisation du code](#organisation-du-code)
  * [Conformité aux protocoles](#conformité-aux-protocoles)
  * [Code inutilisé](#code-inutilisé)
  * [Imports minimaux](#importations-minimales)
* [Espacement](#espacement)
* [Commentaires](#commentaires)
* [Classes et structures](#classes-et-structures)
  * [Utilisation de self](#utilisation-de-self)
  * [Conformité aux protocoles](#conformité-aux-protocoles)
  * [Propriétés calculées](#propriétés-calculées)
  * [Final](#final)
* [Déclarations de fonctions](#déclarations-de-fonctions)
* [Appels de fonctions](#appels-de-fonctions)
* [Expressions de fermeture](#expressions-de-fermeture)
* [Types](#types)
  * [Constantes](#constantes)
  * [Méthodes statiques et propriétés de type variables](#méthodes-statiques-et-propriétés-de-type-variables)
  * [Optionnels](#optionnels)
  * [Initialisation paresseuse](#initialisation-paresseuse)
  * [Inférence de type](#inférence-de-type)
  * [Sucre syntaxique](#sucre-syntaxique)
* [Fonctions vs Méthodes](#fonctions-vs-méthodes)
* [Gestion de la mémoire](#gestion-de-la-mémoire)
  * [Extension de la durée de vie de l'objet](#prolonger-la-durée-de-vie-de-lobjet)
* [Contrôle d'accès](#contrôle-daccès)
* [Flux de contrôle](#flux-de-contrôle)
  * [Opérateur ternaire](#opérateur-ternaire)
* [Chemin doré](#chemin-doré)
  * [Échec des gardes](#échecs-des-déclarations-guard)
* [Point-virgules](#points-virgules)
* [Parenthèses](#parenthèses)
* [Littéraux de chaîne multi-lignes](#littéraux-de-chaînes-multilignes)
* [Pas d'emoji](#pas-demoji)
* [Pas de #imageLiteral ni de #colorLiteral](#pas-de-imageliteral-ou-colorliteral)
* [Organisation et identifiant de bundle](#organisation-et-identifiant-de-bundle)
* [Références](#références)


## Correction

Efforcez-vous de faire en sorte que votre code compile sans avertissements. Cette règle influence de nombreuses décisions de style, telles que l'utilisation de types `#selector` plutôt que de littéraux de chaîne.

## Utilisation de SwiftLint

Lorsque vous écrivez pour Agendrix, il est fortement recommandé, voire peut-être obligatoire selon votre équipe, d'utiliser notre configuration SwiftLint. Consultez la [Politique SwiftLint](SWIFTLINT.markdown) pour plus d'informations.

## Nommage

Un nommage descriptif et cohérent rend le logiciel plus facile à lire et à comprendre. Utilisez les conventions de nommage Swift décrites dans les [Directives de conception de l'API](https://swift.org/documentation/api-design-guidelines/). Voici quelques points importants :

- Cherchez la clarté lors de l'appel d'une méthode.
- Priorisez la clarté plutôt que la brièveté.
- Utilisez la convention `camelCase` (pas `snake_case`).
- Utilisez `UpperCamelCase` pour les types et les protocoles, `lowerCamelCase` pour tout le reste.
- Incluez tous les mots nécessaires tout en omettant les mots superflus.
- Utilisez des noms basés sur les rôles plutôt que sur les types.
- Compensez parfois le manque d'informations sur le type.
- Cherchez une utilisation fluide.
- Commencez les méthodes de fabrication par `make`.
- Nommez les méthodes en fonction de leurs effets secondaires.
  - Les méthodes verbales suivent la règle -ed, -ing pour la version non mutante.
  - Les méthodes nominales suivent la règle formX pour la version mutante.
  - Les types booléens doivent ressembler à des assertions.
  - Les protocoles décrivant _ce qu'est quelque chose_ doivent être nommés comme des noms communs.
  - Les protocoles décrivant _une capacité_ doivent se terminer par _-able_ ou _-ible_.
- Utilisez des termes qui ne surprennent pas les experts ni ne confondent les débutants.
- Évitez généralement les abréviations.
- Suivez les précédents en matière de nommage.
- Préférez les méthodes et les propriétés aux fonctions libres.
- Utilisez une casse uniforme pour les acronymes et les sigles, en majuscules ou en minuscules.
- Donnez le même nom de base aux méthodes qui ont la même signification.
- Évitez les surcharges basées sur le type de retour.
- Choisissez de bons noms de paramètres qui servent de documentation.
- Préférez nommer le premier paramètre plutôt que d'inclure son nom dans le nom de la méthode, sauf mention contraire sous Delegates.
- Étiquetez les paramètres de fermeture et de tuple.
- Profitez des paramètres par défaut.

### Prose

Lorsqu'il s'agit de méthodes dans un texte, il est essentiel d'être sans équivoque. Pour faire référence à un nom de méthode, utilisez la forme la plus simple possible.

1. Écrivez le nom de la méthode sans les paramètres. **Exemple :** Ensuite

, vous devez appeler `addTarget`.
2. Écrivez le nom de la méthode avec les étiquettes d'argument. **Exemple :** Ensuite, vous devez appeler `addTarget(_:action:)`.
3. Écrivez le nom complet de la méthode avec les étiquettes d'argument et les types. **Exemple :** Ensuite, vous devez appeler `addTarget(_: Any?, action: Selector?)`.

Pour l'exemple ci-dessus utilisant `UIGestureRecognizer`, 1 est sans équivoque et préféré.

**Astuce :** Vous pouvez utiliser la barre de navigation de Xcode pour rechercher des méthodes avec des étiquettes d'argument. Si vous êtes particulièrement doué pour appuyer simultanément sur plusieurs touches, placez le curseur dans le nom de la méthode et appuyez sur **Shift-Control-Option-Command-C** (les 4 touches de modification) et Xcode mettra gentiment la signature dans votre presse-papiers.

![Méthodes dans la barre de navigation de Xcode](screens/xcode-jump-bar.png)

### Préfixes de classe

Les types Swift sont automatiquement regroupés par le module qui les contient et vous ne devez pas ajouter de préfixe de classe tel que RW. Si deux noms provenant de modules différents entrent en collision, vous pouvez les différencier en préfixant le nom du type avec le nom du module. Cependant, spécifiez uniquement le nom du module lorsque cela peut prêter à confusion, ce qui devrait être rare.

```swift
import SomeModule

let myClass = MyModule.UsefulClass()
```

### Délégués

Lors de la création de méthodes de délégué personnalisées, un premier paramètre sans nom doit être la source du délégué. (UIKit contient de nombreux exemples de cela.)

**Préféré** :
```swift
func namePickerView(_ namePickerView: NamePickerView, didSelectName name: String)
func namePickerViewShouldReload(_ namePickerView: NamePickerView) -> Bool
```

**Non préféré** :
```swift
func didSelectName(namePicker: NamePickerViewController, name: String)
func namePickerShouldReload() -> Bool
```

### Utiliser le contexte d'inférence de type

Utilisez le contexte d'inférence du compilateur pour écrire un code plus court et clair. (Voir également [Inférence de type](#inférence-de-type).)

**Préféré** :
```swift
let selector = #selector(viewDidLoad)
view.backgroundColor = .red
let toView = context.view(forKey: .to)
let view = UIView(frame: .zero)
```

**Non préféré** :
```swift
let selector = #selector(ViewController.viewDidLoad)
view.backgroundColor = UIColor.red
let toView = context.view(forKey: UITransitionContextViewKey.to)
let view = UIView(frame: CGRect.zero)
```

### Génériques

Les paramètres de type génériques doivent avoir des noms descriptifs en camel case avec une majuscule initiale. Lorsqu'un nom de type n'a pas de relation ou de rôle significatif, utilisez une seule lettre majuscule traditionnelle telle que `T`, `U` ou `V`.

**Préféré** :
```swift
struct Stack<Element> { ... }
func write<Target: OutputStream>(to target: inout Target)
func swap<T>(_ a: inout T, _ b: inout T)
```

**Non préféré** :
```swift
struct Stack<T> { ... }
func write<target: OutputStream>(to target: inout target)
func swap<Thing>(_ a: inout Thing, _ b: inout Thing)
```

### Langue

Utilisez l'orthographe américaine en anglais pour correspondre à l'API d'Apple.

**Préféré** :
```swift
let color = "red"
```

**Non préféré** :
```swift
let colour = "red"
```

## Organisation du code

Utilisez des extensions pour organiser votre code en blocs logiques de fonctionnalités. Chaque extension doit être précédée d'un commentaire `// MARK: -` pour maintenir une bonne organisation.

### Conformité aux protocoles

En particulier, lors de l'ajout de la conformité à un protocole pour un modèle, il est préférable d'ajouter une extension séparée pour les méthodes du protocole. Cela permet de regrouper les méthodes associées au protocole et peut simplifier les instructions pour ajouter un protocole à une classe avec ses méthodes associées.

**Préféré** :
```swift
class MyViewController: UIViewController {
  // du code de classe ici
}

// MARK: - UITableViewDataSource
extension MyViewController: UITableViewDataSource {
  // méthodes du protocole de la source de données de la table
}

// MARK: - UIScrollViewDelegate
extension MyViewController: UIScrollViewDelegate {
  // méthodes du protocole du délégué de la vue déroulante
}
```

**Non préféré** :
```swift
class MyViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
  // toutes les méthodes
}
```

Étant donné que le compilateur ne vous permet pas de redéclarer la conformité à un protocole dans une classe dérivée, il n'est pas toujours nécessaire de reproduire les groupes d'extensions de la classe de base. Cela est particulièrement vrai si la classe dérivée est une classe terminale et qu'un petit nombre de méthodes sont remplacées. La décision de conserver les groupes d'extensions est laissée à la discrétion de l'auteur.

Pour les contrôleurs de vue UIKit, envisagez de regrouper les méthodes du cycle de vie, les accesseurs personnalisés et les IBAction dans des extensions de classe distinctes.

### Code inutilisé

Le code inutilisé (mort), y compris le code de modèle Xcode et les commentaires de placeholder, doit être supprimé. Une exception est lorsque votre tutoriel ou votre livre demande à l'utilisateur d'utiliser le code commenté.

Les méthodes aspirantes qui ne sont pas directement liées au tutoriel et dont l'implémentation appelle simplement la superclasse doivent également être supprimées. Cela inclut toutes les méthodes inutilisées/vides de UIApplicationDelegate.

**Préféré** :
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return Database.contacts.count
}
```

**Non préféré** :
```swift
override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Libérer les ressources qui peuvent être recréées.
}

override func numberOfSections(in tableView: UITableView) -> Int {
  // #warning Implémentation incomplète, retourne le nombre de sections
  return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  // #warning Implémentation incomplète, retourne le nombre de lignes
  return Database.contacts.count
}

```

### Importations minimales

Importez uniquement les modules dont un fichier source a besoin. Par exemple, n'importe pas `UIKit` si l'importation de `Foundation` suffit. De même, n'importe pas `Foundation` si vous devez importer `UIKit`.

**Préféré** :
```swift
import UIKit
var view: UIView
var deviceModels: [String]
```

**Préféré** :
```swift
import Foundation
var deviceModels: [String]
```

**Non préféré** :
```swift
import UIKit
import Foundation
var view: UIView
var deviceModels: [

String]
```

**Non préféré** :
```swift
import UIKit
var deviceModels: [String]
```

## Espacement

* Utilisez une indentation de 2 espaces plutôt que des tabulations pour économiser de l'espace et éviter les retours à la ligne. Assurez-vous de configurer cette préférence dans Xcode et dans les paramètres du projet comme indiqué ci-dessous :

![Paramètres d'indentation dans Xcode](screens/indentation.png)

* Les accolades des méthodes et autres blocs (`if`/`else`/`switch`/`while`, etc.) doivent toujours commencer sur la même ligne que l'instruction, mais se terminer sur une nouvelle ligne.
* Astuce : vous pouvez ré-indenter en sélectionnant du code (ou en appuyant sur **Commande-A** pour tout sélectionner) puis en utilisant **Contrôle-I** (ou **Éditeur ▸ Structure ▸ Ré-indenter** dans le menu). Certains modèles de code Xcode utilisent des tabulations de 4 espaces codées en dur, donc c'est une bonne façon de corriger cela.

**Préféré** :
```swift
if user.isHappy {
  // Faire quelque chose
} else {
  // Faire autre chose
}
```

**Non préféré** :
```swift
if user.isHappy
{
  // Faire quelque chose
}
else {
  // Faire autre chose
}
```

* Il devrait y avoir une ligne vide entre les méthodes et au maximum une ligne vide entre les déclarations de types pour faciliter la clarté visuelle et l'organisation. Les espaces vides à l'intérieur des méthodes doivent séparer les fonctionnalités, mais avoir trop de sections dans une méthode signifie souvent qu'il faut la refactoriser en plusieurs méthodes.

* Il ne devrait pas y avoir de lignes vides après une accolade ou avant une accolade fermante.

* Les parenthèses fermantes ne doivent pas apparaître seules sur une ligne.

**Préféré** :
```swift
let user = try await getUser(
  for: userID,
  on: connection)
```

**Non préféré** :
```swift
let user = try await getUser(
  for: userID,
  on: connection
)
```

* Les deux-points (`:`) n'ont jamais d'espace à gauche et ont un espace à droite. Les exceptions sont l'opérateur ternaire `? :`, le dictionnaire vide `[:]` et la syntaxe `#selector` `addTarget(_:action:)`.

**Préféré** :
```swift
class TestDatabase: Database {
  var data: [String: CGFloat] = ["A": 1.2, "B": 3.2]
}
```

**Non préféré** :
```swift
class TestDatabase : Database {
  var data :[String:CGFloat] = ["A" : 1.2, "B":3.2]
}
```

* Les lignes longues doivent être coupées autour de 70 caractères. Aucune limite stricte n'est spécifiée.

* Évitez les espaces vides à la fin des lignes.

* Ajoutez un seul caractère de nouvelle ligne à la fin de chaque fichier.

## Commentaires

Lorsqu'ils sont nécessaires, utilisez des commentaires pour expliquer **pourquoi** un morceau de code particulier fait quelque chose. Les commentaires doivent être maintenus à jour ou supprimés.

Évitez les commentaires en blocs intégrés au code, car le code dev

rait être autodocumenté autant que possible. _Exception : cela ne s'applique pas aux commentaires utilisés pour générer de la documentation._

Évitez l'utilisation de commentaires de style C (`/* ... */`). Préférez l'utilisation de double slash (`//`) ou de triple slash (`///`).

## Classes et structures

### Lequel utiliser ?

N'oubliez pas que les structures ont une [sémantique de valeur](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_144). Utilisez des structures pour les choses qui n'ont pas d'identité. Un tableau contenant [a, b, c] est vraiment le même qu'un autre tableau contenant [a, b, c] et ils sont complètement interchangeables. Peu importe que vous utilisiez le premier tableau ou le deuxième, car ils représentent exactement la même chose. C'est pourquoi les tableaux sont des structures.

Les classes ont une [sémantique de référence](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_145). Utilisez des classes pour les choses qui ont une identité ou un cycle de vie spécifique. Vous modéliseriez une personne comme une classe car deux objets de personne sont deux choses différentes. Le fait que deux personnes aient le même nom et la même date de naissance ne signifie pas qu'elles sont la même personne. Mais la date de naissance de la personne serait une structure car une date du 3 mars 1950 est la même que n'importe quel autre objet date pour le 3 mars 1950. La date elle-même n'a pas d'identité.

Parfois, des choses devraient être des structures mais doivent se conformer à `AnyObject` ou sont historiquement modélisées en tant que classes (`NSDate`, `NSSet`). Essayez de suivre ces directives aussi étroitement que possible.

### Exemple de définition

Voici un exemple de définition de classe bien stylisée :

```swift
class Circle: Shape {
  var x: Int, y: Int
  var radius: Double
  var diameter: Double {
    get {
      return radius * 2
    }
    set {
      radius = newValue / 2
    }
  }

  init(x: Int, y: Int, radius: Double) {
    self.x = x
    self.y = y
    self.radius = radius
  }

  convenience init(x: Int, y: Int, diameter: Double) {
    self.init(x: x, y: y, radius: diameter / 2)
  }

  override func area() -> Double {
    return Double.pi * radius * radius
  }
}

extension Circle: CustomStringConvertible {
  var description: String {
    return "center = \(centerString) area = \(area())"
  }
  private var centerString: String {
    return "(\(x),\(y))"
  }
}
```

L'exemple ci-dessus illustre les directives de style suivantes :

 + Spécifiez les types des propriétés, variables, constantes, déclarations d'arguments et autres instructions avec un espace après le deux-points mais pas avant, par exemple `x: Int`, et `Circle: Shape`.
 + Définissez plusieurs variables et structures sur une seule ligne si elles ont un but / contexte commun.
 + Indentez les définitions de getter et de setter et les observateurs de propriétés.
 + N'ajoutez pas de modificateurs tels que `internal` lorsqu'ils sont déjà par défaut. De même

, ne répétez pas le modificateur d'accès lors de la substitution d'une méthode.
 + Organisez les fonctionnalités supplémentaires (par exemple, l'impression) dans des extensions.
 + Masquez les détails d'implémentation non partagés, tels que `centerString`, à l'intérieur de l'extension en utilisant le contrôle d'accès `private`.

### Utilisation de Self

Pour des raisons de concision, évitez d'utiliser `self`, car Swift ne l'exige pas pour accéder aux propriétés d'un objet ou invoquer ses méthodes.

Utilisez `self` uniquement lorsque cela est nécessaire par le compilateur (dans les fermetures `@escaping`, ou dans les initialiseurs pour dissocier les propriétés des arguments). En d'autres termes, si cela compile sans `self`, alors omittez-le.

### Propriétés calculées

Pour des raisons de concision, si une propriété calculée est en lecture seule, omettez la clause `get`. La clause `get` est requise uniquement lorsque la clause `set` est fournie.

**Préféré**:
```swift
var diameter: Double {
  return radius * 2
}
```

**Non préféré**:
```swift
var diameter: Double {
  get {
    return radius * 2
  }
}
```

### Final

Marquer des classes ou des membres comme `final` dans les tutoriels peut distraire du sujet principal et n'est pas nécessaire. Néanmoins, l'utilisation de `final` peut parfois clarifier votre intention et en vaut le coût. Dans l'exemple ci-dessous, `Box` a un objectif particulier et la personnalisation dans une classe dérivée n'est pas prévue. Le marquer comme `final` clarifie cela.

```swift
// Transformez n'importe quel type générique en un type de référence en utilisant cette classe Box.
final class Box<T> {
  let value: T
  init(_ value: T) {
    self.value = value
  }
}
```

## Déclarations de fonctions

Gardez les déclarations de fonctions courtes sur une seule ligne, y compris l'accolade ouvrante :

```swift
func reticulateSplines(spline: [Double]) -> Bool {
  // code de réticulation ici
}
```

Pour les fonctions avec des signatures longues, placez chaque paramètre sur une nouvelle ligne et ajoutez une indentation supplémentaire sur les lignes suivantes :

```swift
func reticulateSplines(
  spline: [Double], 
  adjustmentFactor: Double,
  translateConstant: Int, 
  comment: String
) -> Bool {
  // code de réticulation ici
}
```

N'utilisez pas `(Void)` pour représenter l'absence d'une entrée ; utilisez simplement `()`. Utilisez `Void` plutôt que `()` pour les sorties de fermeture et de fonction.

**Préféré**:

```swift
func updateConstraints() -> Void {
  // le code magique se trouve ici
}

typealias CompletionHandler = (result) -> Void
```

**Non préféré**:

```swift
func updateConstraints() -> () {
  // le code magique se trouve ici
}

typealias CompletionHandler = (result) -> ()
```

## Appels de fonctions

Adaptez le style des déclarations de fonctions aux sites d'appel. Les appels qui rentrent sur une seule ligne doivent être écrits de cette façon :

```swift
let success = reticulateSplines(splines)
```

Si le site d'appel doit être enveloppé, placez chaque paramètre sur une nouvelle ligne, avec une indentation supplémentaire :

```swift
let success = reticulateSplines(
  spline: splines,
  adjustmentFactor: 1.3,
  translateConstant: 2,
  comment: "normalize the display")
```

## Expressions de fermeture

Utilisez la syntaxe de fermeture en fin d'appel uniquement s'il y a un seul paramètre d'expression de fermeture à la fin de la liste des arguments. Donnez aux paramètres de la fermeture des noms descriptifs.

**Préféré** :
```swift
UIView.animate(withDuration: 1.0) {
  self.myView.alpha = 0
}

UIView.animate(withDuration: 1.0, animations: {
  self.myView.alpha = 0
}, completion: { finished in
  self.myView.removeFromSuperview()
})
```

**Non préféré** :
```swift
UIView.animate(withDuration: 1.0, animations: {
  self.myView.alpha = 0
})

UIView.animate(withDuration: 1.0, animations: {
  self.myView.alpha = 0
}) { f in
  self.myView.removeFromSuperview()
}
```

Pour les fermetures à une seule expression où le contexte est clair, utilisez les retours implicites :

```swift
attendeeList.sort { a, b in
  a > b
}
```

Les méthodes chaînées utilisant des fermetures en fin d'appel doivent être claires et faciles à lire dans le contexte. Les décisions concernant l'espacement, les sauts de ligne et l'utilisation d'arguments nommés ou anonymes sont laissées à la discrétion de l'auteur. Exemples :

```swift
let value = numbers.map { $0 * 2 }.filter { $0 % 3 == 0 }.index(of

: 90)

let value = numbers
  .map {$0 * 2}
  .filter {$0 > 50}
  .map {$0 + 10}
```

## Types

Utilisez toujours les types et expressions natifs de Swift lorsque cela est possible. Swift propose une compatibilité avec Objective-C, vous permettant ainsi d'utiliser l'ensemble complet des méthodes si nécessaire.

**Préféré** :
```swift
let width = 120.0                                    // Double
let widthString = "\(width)"                         // String
```

**Moins préféré** :
```swift
let width = 120.0                                    // Double
let widthString = (width as NSNumber).stringValue    // String
```

**Non préféré** :
```swift
let width: NSNumber = 120.0                          // NSNumber
let widthString: NSString = width.stringValue        // NSString
```

Dans le code de dessin, utilisez `CGFloat` si cela rend le code plus concis en évitant trop de conversions.

### Constantes

Les constantes sont définies en utilisant le mot-clé `let`, et les variables avec le mot-clé `var`. Utilisez toujours `let` à la place de `var` si la valeur de la variable ne changera pas.

**Astuce** : Une bonne technique consiste à tout définir avec `let` et à le changer en `var` uniquement si le compilateur se plaint !

Vous pouvez définir des constantes sur un type plutôt que sur une instance de ce type en utilisant des propriétés de type. Pour déclarer une propriété de type en tant que constante, utilisez simplement `static let`. Les propriétés de type déclarées de cette manière sont généralement préférées aux constantes globales car elles sont plus faciles à distinguer des propriétés d'instance. Exemple :

**Préféré** :
```swift
enum Math {
  static let e = 2.718281828459045235360287
  static let root2 = 1.41421356237309504880168872
}

let hypotenuse = side * Math.root2
```

**Note** : L'avantage d'utiliser une énumération sans cas est qu'elle ne peut pas être instanciée accidentellement et fonctionne comme un espace de noms pur.

**Non préféré** :
```swift
let e = 2.718281828459045235360287  // pollue l'espace de noms global
let root2 = 1.41421356237309504880168872

let hypotenuse = side * root2 // qu'est-ce que root2 ?
```

### Méthodes statiques et propriétés de type variables

Les méthodes statiques et les propriétés de type fonctionnent de manière similaire aux fonctions et variables globales et doivent être utilisées avec parcimonie. Elles sont utiles lorsque la fonctionnalité est limitée à un type particulier ou lorsque l'interopérabilité avec Objective-C est requise.

### Optionnels

Déclarez les variables et les types de retour des fonctions comme optionnels avec `?` là où une valeur `nil` est acceptable.

Utilisez des types à déballage implicite déclarés avec `!` uniquement pour les variables d'instance que vous savez être initialisées ultérieurement avant leur utilisation, comme les sous-vues qui seront configurées dans `viewDidLoad()`. Privilégiez la liaison optionnelle plutôt que les optionnels à déballage implicite dans la plupart des autres cas.

Lors de l'accès à une valeur optionnelle, utilisez le

 chaînage optionnel (`optional chaining`) si la valeur n'est accessible qu'une seule fois ou s'il y a de nombreux optionnels dans la chaîne :

```swift
textContainer?.textLabel?.setNeedsDisplay()
```

Utilisez la liaison optionnelle lorsque cela est plus pratique pour déballer une fois et effectuer plusieurs opérations :

```swift
if let textContainer = textContainer {
  // faire de nombreuses choses avec textContainer
}
```

**Notes** : Swift 5.7 a introduit une nouvelle syntaxe abrégée pour déballer les optionnels dans des variables ombragées :

```swift
if let textContainer {
  // faire de nombreuses choses avec textContainer
}
```

Lorsque vous nommez des variables et des propriétés optionnelles, évitez de les nommer comme `optionalString` ou `maybeView`, car leur optionnalité est déjà déclarée dans le type.

Pour la liaison optionnelle, utilisez un nouveau nom de variable plutôt que d'utiliser des noms comme `unwrappedView` ou `actualLabel`.

**Préféré** :
```swift
var subview: UIView?
var volume: Double?

// plus tard...
if let subview = subview, let volume = volume {
  // faire quelque chose avec subview et volume déballés
}

// autre exemple
resource.request().onComplete { [weak self] response in
  guard let self = self else { return }
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Non préféré** :
```swift
var optionalSubview: UIView?
var volume: Double?

if let unwrappedSubview = optionalSubview {
  if let realVolume = volume {
    // faire quelque chose avec unwrappedSubview et realVolume
  }
}

// autre exemple
UIView.animate(withDuration: 2.0) { [weak self] in
  guard let strongSelf = self else { return }
  strongSelf.alpha = 1.0
}
```

### Initialisation paresseuse

Envisagez d'utiliser l'initialisation paresseuse (`lazy initialization`) pour un contrôle plus précis de la durée de vie des objets. Cela est particulièrement vrai pour les `UIViewController` qui chargent les vues de manière paresseuse. Vous pouvez utiliser une closure qui est immédiatement appelée `{ }()` ou appeler une méthode de fabrique privée. Exemple :

```swift
lazy var locationManager = makeLocationManager()

private func makeLocationManager() -> CLLocationManager {
  let manager = CLLocationManager()
  manager.desiredAccuracy = kCLLocationAccuracyBest
  manager.delegate = self
  manager.requestAlwaysAuthorization()
  return manager
}
```

**Notes** :
  - `[unowned self]` n'est pas nécessaire ici. Il n'y a pas de rétention cyclique créée.
  - Le gestionnaire de localisation a un effet secondaire en faisant apparaître une interface utilisateur pour demander la permission à l'utilisateur, il est donc logique d'avoir un contrôle plus précis ici.


### Inférence de type

Privilégiez un code concis et laissez le compilateur inférer le type des constantes ou variables d'instances uniques. L'inférence de type est également appropriée pour les tableaux et dictionnaires petits et non vides. Si nécessaire, spécifiez le type spécifique tel que `CGFloat` ou `Int16`.

**Préféré** :
```swift
let message = "Cliquez sur le bouton"
let currentBounds = computeViewBounds()
var names = ["Mic", "Sam", "Christine"]
let maximumWidth: CGFloat = 106.5
```

**Non préféré** :
```swift
let message: String = "Cliquez sur le bouton"
let currentBounds: CGRect = computeViewBounds()
var names = [String]()
```

#### Annotation de type pour les tableaux et dictionnaires vides

Pour les tableaux et dictionnaires vides, utilisez l'annotation de type. (Pour un tableau ou un dictionnaire attribué à un littéral volumineux et multiligne, utilisez l'annotation de type.)

**Préféré** :
```swift
var names: [String] = []
var lookup: [String: Int] = [:]
```

**Non préféré** :
```swift
var names = [String]()
var lookup = [String: Int]()
```

**NOTE** : En suivant cette directive, il est encore plus important de choisir des noms descriptifs.

### Sucre syntaxique

Préférez les versions abrégées des déclarations de type à la syntaxe générique complète.

**Préféré** :
```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```

**Non préféré** :
```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```

## Fonctions vs Méthodes

Les fonctions libres, qui ne sont pas attachées à une classe ou à un type, doivent être utilisées avec parcimonie. Dans la mesure du possible, préférez utiliser une méthode plutôt qu'une fonction libre. Cela facilite la lisibilité et la découvrabilité.

Les fonctions libres sont les plus appropriées lorsqu'elles ne sont associées à aucun type ou instance particulière.

**Préféré** :
```swift
let sorted = items

.mergeSorted()  // facilement découvrable
rocket.launch()  // agit sur le modèle
```

**Non préféré** :
```swift
let sorted = mergeSort(items)  // difficile à découvrir
launch(&rocket)
```

**Exceptions pour les fonctions libres**
```swift
let tuples = zip(a, b)  // se sent naturel en tant que fonction libre (symétrie)
let value = max(x, y, z)  // une autre fonction libre qui semble naturelle
```

## Gestion de la mémoire

Le code (même le code de démonstration non destiné à la production) ne doit pas créer de cycles de référence. Analysez votre graphe d'objets et évitez les cycles forts en utilisant des références `weak` et `unowned`. Vous pouvez également utiliser des types de valeurs (`struct`, `enum`) pour éviter les cycles.

### Prolonger la durée de vie de l'objet

Prolongez la durée de vie d'un objet en utilisant l'idiotisme `[weak self]` et `guard let self = self else { return }`. L'utilisation de `[weak self]` est préférée à `[unowned self]` lorsque cela n'est pas immédiatement évident que `self` survit à la fermeture. Prolonger explicitement la durée de vie est préféré à l'utilisation de chaînage optionnel.

**Préféré**
```swift
resource.request().onComplete { [weak self] response in
  guard let self = self else {
    return
  }
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Non préféré**
```swift
// peut planter si self est libéré avant que la réponse ne soit renvoyée
resource.request().onComplete { [unowned self] response in
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Non préféré**
```swift
// la désallocation pourrait se produire entre la mise à jour du modèle et la mise à jour de l'interface utilisateur
resource.request().onComplete { [weak self] response in
  let model = self?.updateModel(response)
  self?.updateUI(model)
}
```

## Contrôle d'accès

Dans les tutoriels, l'annotation de contrôle d'accès complet peut distraire du sujet principal et n'est pas nécessaire. Cependant, utiliser `private` et `fileprivate` de manière appropriée ajoute de la clarté et favorise l'encapsulation. Privilégiez `private` à `fileprivate` ; utilisez `fileprivate` uniquement lorsque le compilateur l'exige.

Utilisez le contrôle d'accès en tant que spécificateur de propriété principal. Les seules choses qui doivent précéder le contrôle d'accès sont le spécificateur `static` ou des attributs tels que `@IBAction`, `@IBOutlet` et `@discardableResult`.

**Préféré**:
```swift
private let message = "Great Scott!"

class TimeMachine {  
  private dynamic lazy var fluxCapacitor = FluxCapacitor()
}
```

**Non préféré**:
```swift
fileprivate let message = "Great Scott!"

class TimeMachine {  
  lazy dynamic private var fluxCapacitor = FluxCapacitor()
}
```

## Flux de contrôle

Privilégiez le style `for-in` des boucles `for` par rapport au style `while-condition-increment`.

**Préféré**:
```swift
for _ in 0..<3 {
  print("Bonjour trois fois")
}

for (index, person) in attendeeList.enumerated() {
  print("\(person) est à la position n°\(index)")
}

for index in stride(from: 0, to: items.count, by: 2) {
  print(index)
}

for index in (0...3).reversed() {
  print(index)
}
```

**Non préféré**

:
```swift
var i = 0
while i < 3 {
  print("Bonjour trois fois")
  i += 1
}


var i = 0
while i < attendeeList.count {
  let person = attendeeList[i]
  print("\(person) est à la position n°\(i)")
  i += 1
}
```

### Opérateur ternaire

L'opérateur ternaire, `?:`, ne devrait être utilisé que lorsqu'il améliore la clarté ou la lisibilité du code. En général, une seule condition devrait être évaluée. Lorsqu'il y a plusieurs conditions, il est généralement plus compréhensible d'utiliser une déclaration `if` ou de refactoriser le code en utilisant des variables d'instance. En règle générale, la meilleure utilisation de l'opérateur ternaire est lors de l'assignation d'une variable pour décider quelle valeur utiliser.

**Préféré**:

```swift
let value = 5
result = value != 0 ? x : y

let isHorizontal = true
result = isHorizontal ? x : y
```

**Non préféré**:

```swift
result = a > b ? x = c > d ? c : d : y
```

## Chemin doré

Lorsque vous utilisez des conditions, la marge gauche du code devrait représenter le "chemin doré" ou "heureux". Cela signifie qu'il ne faut pas imbriquer les déclarations `if`. Avoir plusieurs instructions `return` est acceptable. L'instruction `guard` est conçue pour cela.

**Préféré**:
```swift
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {
  guard let context = context else {
    throw FFTError.noContext
  }
  guard let inputData = inputData else {
    throw FFTError.noInputData
  }

  // utilisez le contexte et les données d'entrée pour calculer les fréquences
  return frequencies
}
```

**Non préféré**:
```swift
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {
  if let context = context {
    if let inputData = inputData {
      // utilisez le contexte et les données d'entrée pour calculer les fréquences

      return frequencies
    } else {
      throw FFTError.noInputData
    }
  } else {
    throw FFTError.noContext
  }
}
```

Lorsque plusieurs optionnels sont déballés avec `guard` ou `if let`, réduisez au minimum l'imbrication en utilisant la version composée lorsque cela est possible. Dans la version composée, placez le `guard` sur sa propre ligne, puis indentez chaque condition sur sa propre ligne. La clause `else` est indentée de manière à correspondre au `guard` lui-même, comme indiqué ci-dessous. Exemple :

**Préféré**:
```swift
guard 
  let number1 = number1,
  let number2 = number2,
  let number3 = number3 
else {
  fatalError("impossible")
}
// faites quelque chose avec les nombres
```

**Non préféré**:
```swift
if let number1 = number1 {
  if let number2 = number2 {
    if let number3 = number3 {
      // faites quelque chose avec les nombres
    } else {
      fatalError("impossible")
    }
  } else {
    fatalError("impossible")
  }
} else {
  fatalError("impossible")
}
```

### Échecs des déclarations `guard`

Les déclarations `guard` doivent avoir un moyen de sortie. En général, il s'agit d'une simple instruction d'une ligne, telle que `return`, `throw`, `break`, `continue`

 ou `fatalError()`. Les blocs de code importants doivent être évités. Si vous devez effectuer un nettoyage pour plusieurs points de sortie, envisagez d'utiliser un bloc `defer` pour éviter la duplication du code de nettoyage.

## Points-virgules

En Swift, un point-virgule n'est pas nécessaire après chaque instruction dans votre code. Ils ne sont nécessaires que si vous souhaitez combiner plusieurs instructions sur une seule ligne.

Ne pas écrire plusieurs instructions sur une seule ligne séparées par des points-virgules.

**Préféré**:
```swift
let swift = "pas un langage de script"
```

**Non préféré**:
```swift
let swift = "pas un langage de script";
```

**REMARQUE** : Swift est très différent de JavaScript, où l'omission des points-virgules est [généralement considérée comme non sécurisée](https://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)

## Parenthèses

Les parenthèses autour des conditions ne sont pas requises et devraient être omises.

**Préféré**:
```swift
if name == "Bonjour" {
  print("Monde")
}
```

**Non préféré**:
```swift
if (name == "Bonjour") {
  print("Monde")
}
```

Dans les expressions plus complexes, l'utilisation optionnelle de parenthèses peut parfois rendre le code plus lisible.

**Préféré**:
```swift
let playerMark = (player == current ? "X" : "O")
```

## Littéraux de chaînes multilignes

Lorsque vous construisez une chaîne de caractères longue, il est recommandé d'utiliser la syntaxe des littéraux de chaîne multilignes. Ouvrez le littéral à la même ligne que l'assignation, mais ne mettez pas de texte sur cette ligne. Indentez le bloc de texte d'un niveau supplémentaire.

**Préféré**:

```swift
let message = """
  Vous ne pouvez pas charger le flux \
  condensateur avec une pile de 9V.
  Vous devez utiliser un super-chargeur \
  qui coûte 10 crédits. Vous avez actuellement \
  \(credits) crédits disponibles.
  """
```

**Non préféré**:

```swift
let message = """Vous ne pouvez pas charger le flux \
  condensateur avec une pile de 9V.
  Vous devez utiliser un super-chargeur \
  qui coûte 10 crédits. Vous avez actuellement \
  \(credits) crédits disponibles.
  """
```

**Non préféré**:

```swift
let message = "Vous ne pouvez pas charger le flux " +
  "condensateur avec une pile de 9V.\n" +
  "Vous devez utiliser un super-chargeur " +
  "qui coûte 10 crédits. Vous avez actuellement " +
  "\(credits) crédits disponibles."
```

## Pas d'emoji

N'utilisez pas d'emoji dans vos projets. Pour les lecteurs qui saisissent réellement leur code, c'est une source de friction inutile. Bien que cela puisse être mignon, cela n'apporte rien à l'apprentissage et interrompt le flux de codage pour ces lecteurs.

## Pas de #imageLiteral ou #colorLiteral

De même, n'utilisez pas la possibilité de Xcode de faire glisser une couleur ou une image dans une instruction source. Cela se transforme en #colorLiteral et #imageLiteral, respectivement, et présente des difficultés désagréables pour un lecteur qui essaie de les saisir en fonction du texte du tutoriel. Utilisez plutôt `UIColor(red:green:blue)` et `UIImage(imageLiteralResourceName:)`.

## Organisation et identifiant de bundle

Lorsqu'un projet Xcode est utilisé, l'organisation doit être définie sur `Agendrix` et l'identifiant de bundle sur `com.yourcompany.TutorialName` où `TutorialName` est le nom du projet du tutoriel.

![Réglages du projet Xcode](screens/project_settings.png)

## Références

* [Les directives de conception de l'API Swift](https://swift.org/documentation/api-design-guidelines/)
* [Le langage de programmation Swift](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/index.html) (en anglais)
* [Utilisation de Swift avec Cocoa et Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html) (en anglais)
* [Référence de la bibliothèque standard Swift](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html) (en anglais)
