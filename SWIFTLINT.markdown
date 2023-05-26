# La politique officielle d'Agendrix pour SwiftLint

La configuration SwiftLint de ce référentiel est conçue pour garantir que le travail que nous créons chez Agendrix est conforme à [Le Guide de style Swift officiel d'Agendrix](./README.markdown).

L'objectif de ce style est d'améliorer la lisibilité de nos publications imprimées et en ligne. Par conséquent, ce style peut être différent de celui que vous avez utilisé auparavant, car les exigences de la lecture imprimée et en ligne sont différentes des autres contextes.

Les politiques décrites ici ont pour objectif d'assurer la cohérence entre tous nos projets, ce qui permettra également de fluidifier le flux de contenu dans notre processus d'édition. Certains choix visent également à alléger autant que possible la charge pour nos lecteurs.

Ces guides utilisent SwiftLint comme norme. Vous pouvez en savoir plus sur SwiftLint en visitant sa [page de documentation officielle](https://github.com/realm/SwiftLint).

## Table des matières

* [Installation de SwiftLint](#installation-de-swiftlint)
* [Paramètres de Xcode](#paramètres-de-xcode)
* [Exécution de SwiftLint](#exécution-de-swiftlint)
* [Gestion des exceptions de règles](#gestion-des-exceptions-de-règles)
* [Exceptions approuvées](#exceptions-approuvées)
    * [Optionnels à déballage implicite](#optionnels-à-déballage-implicite)
    * [Cast forcé](#cast-forcé)
    * [Déballage forcé](#déballage-forcé)
    * [SwiftUI et plusieurs fermetures de traînée](#swiftui-et-plusieurs-fermetures-de-traînée)
    * [Fichiers open source](#fichiers-open-source)
* [Autres remarques](#autres-remarques)

## Installation de SwiftLint

Nous recommandons aux membres de l'équipe d'Agendrix d'installer SwiftLint à l'aide de Homebrew :

```bash
brew install swiftlint
```

Si vous ne pouvez pas utiliser Homebrew, vous pouvez utiliser l'une des autres méthodes décrites dans la [documentation de SwiftLint](https://github.com/realm/SwiftLint).

**Ne** pas installer SwiftLint en tant que CocoaPod dans votre projet.

## Paramètres de Xcode

Vous devrez configurer Xcode pour supprimer les espaces vides en fin de ligne. Ce n'est pas la configuration par défaut.

Dans les préférences de Xcode, sélectionnez **Text Editing** ▸ **Editing** et co

chez **Including whitespace-only lines**.

![](screens/trailing-whitespace.png)

## Exécution de SwiftLint

Pour simplifier le processus pour tous les acteurs du flux de contenu, vous devrez ajouter les instructions nécessaires à votre projet d'exemple pour exécuter SwiftLint automatiquement à chaque génération. Pour ce faire :

1. Sélectionnez le document du projet dans le navigateur de projet.
2. Sélectionnez l'onglet **Build Phases**.
3. Cliquez sur **+** et choisissez **New Run Script Phase**.

![](screens/add-run-script.png)

4. Faites glisser la nouvelle phase avant la phase **Compile Sources**.
5. Cliquez sur le triangle de déroulement de la phase **Run Script** et assurez-vous que **Shell** est défini sur **/bin/sh**.

![](screens/empty-run-script.png)

6. Ajoutez le script suivant :
```
PATH=/opt/homebrew/bin:$PATH
if [ -f ~/com.raywenderlich.swiftlint.yml ]; then
  if which swiftlint >/dev/null; then
    swiftlint --no-cache --config ~/com.raywenderlich.swiftlint.yml
  fi
fi
```

## Gestion des exceptions de règles

Votre projet d'exemple doit compiler sans avertissements, que ce soit SwiftLint ou autre. En général, vous devriez modifier votre code pour éliminer tous les avertissements lorsque cela est nécessaire. Cependant, il y aura des moments où cela ne sera pas possible en ce qui concerne SwiftLint. Dans ces situations, vous devrez utiliser des commentaires en ligne pour désactiver temporairement les règles. Vous pouvez trouver la syntaxe appropriée pour cela dans [la documentation de SwiftLint](https://realm.github.io/SwiftLint/#disable-rules-in-code).

Vous ne pouvez désactiver une règle que si elle figure sur la liste des exceptions approuvées énumérées ci-dessous.

Préférez la forme qui désactive une règle uniquement pour la ligne suivante :
```
// swiftlint:disable:next implicitly_unwrapped_optional
var injectedValue: Data!
```

Ou, de manière similaire, pour la ligne précédente :
```
var injectedValue: Data!
// swiftlint:disable:previous implicitly_unwrapped_optional
```

S'il y a plusieurs exceptions approuvées, regroupez-les et désactivez la règle pour cette région. Assurez-vous d'activer à nouveau la règle après cette section. Ne laissez pas une règle désactivée dans l'ensemble du fichier source.

```
// swiftlint:disable implicitly_unwrapped_optional
var injectedValue1: Data!
var injectedValue2: Data!
// swiftlint:enable implicitly_unwrapped_optional
```

Si vous devez désactiver des règles dans votre projet, laissez ces commentaires en ligne dans le projet pour le bénéfice de vos coéquipiers dans le flux d'édition.

Enfin, si vous n'êtes pas sûr de quelle règle déclenche un avertissement, vous pouvez trouver le nom de la règle entre parenthèses à la fin du message :

![](screens/swiftlint-warning.png)

## Exceptions approuvées

Il existe certains idiomes courants qui contreviennent aux vérifications strictes de SwiftLint. Si vous ne parvenez pas à les contourner, et si vous avez déjà essayé de trouver une meilleure façon de structurer votre code,

 vous pouvez désactiver des règles comme décrit dans cette section.

### Implicitly Unwrapped Optionals

Il est parfois courant, au lieu d'utiliser l'injection de dépendances, de déclarer les propriétés d'un contrôleur de vue enfant comme des Implicitly Unwrapped Optionals (IUO). Si vous ne parvenez pas à structurer votre projet pour éviter cela, vous pouvez désactiver la règle `implicitly_unwrapped_optional` pour ces déclarations de dépendance. Avec l'avènement de `@IBSegueAction`, cela devrait être rare.

### Force Cast

Vous pouvez utiliser la conversion forcée (force casting) et désactiver la règle `force_cast` dans les méthodes `UITableViewDataSource` et `UICollectionViewDataSource` qui défilent les cellules.

### Force Unwrapping

Vous pouvez utiliser le déballage forcé (force unwrapping) - règle nommée `force_unwrap` - lors du retour d'une couleur à partir d'un catalogue de ressources :

```
static var rwGreen: UIColor {
  // swiftlint:disable:next force_unwrapping
  UIColor(named: "rw-green")!
}
```

Vous pouvez également l'utiliser dans le même contexte que l'exception de force cast ci-dessus, lors du défilement des cellules dans les méthodes `UITableViewDataSource` et `UICollectionViewDataSource`.

Bien que nous préférions que vous modélisiez un code approprié et défensif pour nos lecteurs, vous pouvez utiliser le déballage forcé pour accéder à des ressources que vous **savez** être incluses dans le bundle de l'application.

Enfin, vous pouvez utiliser le déballage forcé lors de la construction d'une `URL` à partir d'une chaîne d'URL codée en dur et garantie valide.

### SwiftUI et plusieurs closures de fin

SwiftUI idiomatique utilise des closures de fin pour fournir le contenu de vue pour certains éléments d'interface utilisateur. `Button` en est un exemple typique ; il a une forme d'initialisation qui utilise une closure pour fournir son `label`. Il est courant d'écrire quelque chose comme ceci :

```
Button(action: { self.isPresented.toggle() }) {
  Image(systemName: "plus")
}
```

Cela contrevient à la règle selon laquelle vous ne devez pas utiliser la syntaxe de closure de fin lorsqu'une méthode accepte plusieurs paramètres de closure, donc SwiftLint le signalera avec un avertissement.

Vous pouvez contourner cela en extrayant l'action du `Button` dans une méthode séparée. Bien que ce soit souvent une meilleure solution lorsque l'action nécessite plusieurs instructions, cela peut être une exigence fastidieuse lorsque l'action est une seule instruction, comme dans l'exemple ci-dessus.

Dans ces cas, vous êtes autorisé à désactiver cette règle **pour la déclaration d'une vue SwiftUI uniquement**. Le nom de la règle est `multiple_closures_with_trailing_closure`.

### Fichiers open-source

Occasionnellement, il sera nécessaire d'inclure un fichier open-source non modifié dans le projet d'exemple. Il est pratiquement certain que ces fichiers ne seront pas conformes à notre guide de style. Notre pratique a toujours été de laisser ces fichiers dans leur état d'origine. Dans cette situation, vous devez désactiver SwiftLint pour l'ensemble du fichier :

```
// swiftlint:disable all
```

## Autres remarques

Bien

 que SwiftLint soit un outil puissant pour améliorer la cohérence et la qualité de notre code, il est important de se rappeler qu'il ne doit pas être utilisé de manière dogmatique. Il existe des situations où les règles peuvent être désactivées de manière appropriée pour améliorer la lisibilité ou l'efficacité du code.

N'hésitez pas à discuter avec vos collègues et à poser des questions si vous avez des doutes sur l'utilisation de SwiftLint ou les exceptions approuvées pour ce guide de style.