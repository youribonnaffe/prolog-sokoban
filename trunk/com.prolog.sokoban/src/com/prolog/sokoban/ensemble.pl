/*****************************************************************************/
/* TP Prolog : exercice sur les ensembles                                    */
/*                                                                           */
/* Par : Youri Bonnaff�                                                      */
/*       Sylvain Jeanne                                                      */
/*       (4IF1)                                                              */
/*****************************************************************************/

/* isEnsemble(E) : vrai si E est un ensemble, faux sinon
		Un ensemble est une liste ne contenant pas de doublons
		On utilise un algorithme r�cursif qui consiste � v�rifier que chaque �l�ment n'est pas pr�sent en double
*/		
% une liste vide est un ensemble
isEnsemble([]).
% on extrait le premier �l�ment appel� X, le reste de la list est E
% on v�rifie que X n'appartient pas � E
% on v�rifie que E est un ensemble
isEnsemble([X|E]):-isNotElmt(X,E),isEnsemble(E).

/* isNotElmt(X,L) : vrai si l'�l�ment X n'appartient pas � la liste L
	La v�rification se fait de mani�re r�cursive
*/
% n'importe quel �l�ment X n'appartient pas � une liste vide
isNotElmt(_,[]).
% X n'appartient pas � L si X est diff�rent de T l'�l�ment de t�te de L
% et si X n'appartient pas � L (isNotElmnt(X,L)
isNotElmt(X,[T|L]):-X\=T,isNotElmt(X,L).



/* rmDoublon(L,E) : cr�e un ensemble E � partir d'une liste L
	Il s'agit donc de supprimer les doublons de L
*/
% une liste vide donnera un ensemble vide
rmDoublon([],[]).
% on retire l'�l�ment en t�te du reste de la liste (on supprime ses doublons) et on continue pour le reste de la liste
rmDoublon([T|L],[T|E]):-rmElmt(T,L,P),rmDoublon(P,E).



/* rmElmt(X,L,P) : retire l'�l�ment X de L et place le r�sultat dans P
*/
% retirer un �l�ment d'une liste vide donne la liste vide
rmElmt(_,[],[]).
% si l'�l�ment � retirer est en t�te de la liste alors on ne garde que la liste sans la t�te et continue pour le reste de la liste
rmElmt(X,[X|L],S):-rmElmt(X,L,S).
% sinon on ne retire pas cet �l�ment et on continue � d�rouler pour le reste de la liste
rmElmt(X,[W|L],[W|S]):-X\=W,rmElmt(X,L,S).



/* union(E1,E2,E) : r�alise l'union de l'ensemble E1 et E2 dans l'ensemble E*/
% l'union est la concat�nation de E1 et E2 dans E3 puis la suppression des doublons afin d'obtenir un ensemble
union(E1,E2,E):-conc(E1,E2,E3),rmDoublon(E3,E).

/* conc(L1,L2,L3) : r�alise la concat�nation de L1 et L2 dans L3 */
% concat�ner une liste vide � une autre liste ne change pas cette derni�re
conc([],L2,L2).
% on prendre le premier �l�ment de L1 pour le mettre dans L3, auparavant on aura appel� conc(L,L2,L3)
% L3 sera d'abord remplie par L2, puis les �l�ments de L1 sont ajout�s (en partant de la fin)
conc([A|L],L2,[A|L3]):-conc(L,L2,L3).



/* intersection(E1,E2,E) : r�alise l'intersection de l'ensemble E1 avec E2 et place le r�sultat dans E 
 (E1 et E2 sont suppos�s �tre des ensembles)
*/
% l'intersection de l'ensemble vide avec n'importe quel ensemble donne l'ensemble vide
intersection([],_,[]).
% si l'�l�ment A en t�te de E1 est dans E2 alors on l'ajoute au r�sultat
% not(isNotElmnt) �quivaudrait � un isElmnt, c'est � dire vrai si l'�l�ment appartient � la liste
intersection([A|E1],E2,[A|E]):-not(isNotElmt(A,E2)),intersection(E1,E2,E).
% si l'�l�ment A n'est pas dans E2 alors on ne l'ajoute pas � E
intersection([A|E1],E2,E):-isNotElmt(A,E2),intersection(E1,E2,E).



/* diff(E1,E2,E) : r�alise la diff�rence E1-E2 et place le r�sultat dans E
 (E1 et E2 sont suppos�s �tre des ensembles)
*/
% si on enl�ve n'importe quoi � l'ensemble vide alors on obtient toujours l'ensemble vide
diff([],_,[]).
% si A, t�te de E1, n'est pas pr�sent dans E2 alors on le laisse dans le r�sultat
diff([A|E1],E2,[A|E]):-isNotElmt(A,E2),diff(E1,E2,E).
% si A, t�te de E2 est pr�sent dans E2 alors l'enl�ve du r�sultat
diff([A|E1],E2,E):-not(isNotElmt(A,E2)),diff(E1,E2,E).

/* egalite(E1,E2) : vrai si l'ensemble E1 et E2 contiennent les m�mes �l�ments 
	(E1 et E2 sont suppos�s �tre des ensembles)
	on cherche les �l�ments communs � E1 et E2 et on les supprime
	si on obtient deux ensembles vides alors E1=E2
*/
% E1 et E2 sont vides, ils sont donc �gaux
egalite([],[]).
% on enl�ve le premier �l�ment de E1 si il est dans E2 et recommence pour ce qu'il reste des deux ensembles
egalite([A|E1],E2):-not(isNotElmt(A,E2)),rmElmt(A,E2,E3),egalite(E1,E3).

