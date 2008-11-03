/*****************************************************************************/
/* TP Prolog : exercice sur les ensembles                                    */
/*                                                                           */
/* Par : Youri Bonnaffé                                                      */
/*       Sylvain Jeanne                                                      */
/*       (4IF1)                                                              */
/*****************************************************************************/

/* isEnsemble(E) : vrai si E est un ensemble, faux sinon
		Un ensemble est une liste ne contenant pas de doublons
		On utilise un algorithme récursif qui consiste à vérifier que chaque élément n'est pas présent en double
*/		
% une liste vide est un ensemble
isEnsemble([]).
% on extrait le premier élément appelé X, le reste de la list est E
% on vérifie que X n'appartient pas à E
% on vérifie que E est un ensemble
isEnsemble([X|E]):-isNotElmt(X,E),isEnsemble(E).

/* isNotElmt(X,L) : vrai si l'élément X n'appartient pas à la liste L
	La vérification se fait de manière récursive
*/
% n'importe quel élément X n'appartient pas à une liste vide
isNotElmt(_,[]).
% X n'appartient pas à L si X est différent de T l'élément de tête de L
% et si X n'appartient pas à L (isNotElmnt(X,L)
isNotElmt(X,[T|L]):-X\=T,isNotElmt(X,L).



/* rmDoublon(L,E) : crée un ensemble E à partir d'une liste L
	Il s'agit donc de supprimer les doublons de L
*/
% une liste vide donnera un ensemble vide
rmDoublon([],[]).
% on retire l'élément en tête du reste de la liste (on supprime ses doublons) et on continue pour le reste de la liste
rmDoublon([T|L],[T|E]):-rmElmt(T,L,P),rmDoublon(P,E).



/* rmElmt(X,L,P) : retire l'élément X de L et place le résultat dans P
*/
% retirer un élément d'une liste vide donne la liste vide
rmElmt(_,[],[]).
% si l'élément à retirer est en tête de la liste alors on ne garde que la liste sans la tête et continue pour le reste de la liste
rmElmt(X,[X|L],S):-rmElmt(X,L,S).
% sinon on ne retire pas cet élément et on continue à dérouler pour le reste de la liste
rmElmt(X,[W|L],[W|S]):-X\=W,rmElmt(X,L,S).



/* union(E1,E2,E) : réalise l'union de l'ensemble E1 et E2 dans l'ensemble E*/
% l'union est la concaténation de E1 et E2 dans E3 puis la suppression des doublons afin d'obtenir un ensemble
union(E1,E2,E):-conc(E1,E2,E3),rmDoublon(E3,E).

/* conc(L1,L2,L3) : réalise la concaténation de L1 et L2 dans L3 */
% concaténer une liste vide à une autre liste ne change pas cette dernière
conc([],L2,L2).
% on prendre le premier élément de L1 pour le mettre dans L3, auparavant on aura appelé conc(L,L2,L3)
% L3 sera d'abord remplie par L2, puis les éléments de L1 sont ajoutés (en partant de la fin)
conc([A|L],L2,[A|L3]):-conc(L,L2,L3).



/* intersection(E1,E2,E) : réalise l'intersection de l'ensemble E1 avec E2 et place le résultat dans E 
 (E1 et E2 sont supposés être des ensembles)
*/
% l'intersection de l'ensemble vide avec n'importe quel ensemble donne l'ensemble vide
intersection([],_,[]).
% si l'élément A en tête de E1 est dans E2 alors on l'ajoute au résultat
% not(isNotElmnt) équivaudrait à un isElmnt, c'est à dire vrai si l'élément appartient à la liste
intersection([A|E1],E2,[A|E]):-not(isNotElmt(A,E2)),intersection(E1,E2,E).
% si l'élément A n'est pas dans E2 alors on ne l'ajoute pas à E
intersection([A|E1],E2,E):-isNotElmt(A,E2),intersection(E1,E2,E).



/* diff(E1,E2,E) : réalise la différence E1-E2 et place le résultat dans E
 (E1 et E2 sont supposés être des ensembles)
*/
% si on enlève n'importe quoi à l'ensemble vide alors on obtient toujours l'ensemble vide
diff([],_,[]).
% si A, tête de E1, n'est pas présent dans E2 alors on le laisse dans le résultat
diff([A|E1],E2,[A|E]):-isNotElmt(A,E2),diff(E1,E2,E).
% si A, tête de E2 est présent dans E2 alors l'enlève du résultat
diff([A|E1],E2,E):-not(isNotElmt(A,E2)),diff(E1,E2,E).

/* egalite(E1,E2) : vrai si l'ensemble E1 et E2 contiennent les mêmes éléments 
	(E1 et E2 sont supposés être des ensembles)
	on cherche les éléments communs à E1 et E2 et on les supprime
	si on obtient deux ensembles vides alors E1=E2
*/
% E1 et E2 sont vides, ils sont donc égaux
egalite([],[]).
% on enlève le premier élément de E1 si il est dans E2 et recommence pour ce qu'il reste des deux ensembles
egalite([A|E1],E2):-not(isNotElmt(A,E2)),rmElmt(A,E2,E3),egalite(E1,E3).

