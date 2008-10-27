liaison(bb,bc).%
liaison(bb,cb).%
liaison(bc,cc).%

liaison(cb,cc).%
liaison(cb,db).%
liaison(cc,cd).%
liaison(cc,dc).%
liaison(cd,ce).%
liaison(cd,dd).%
liaison(ce,de).%

liaison(db,dc).%
liaison(dc,dd).%
liaison(dd,de).%
liaison(dd,ed).%

liaison(ed,fd).%

liaison(fb,fc).%
liaison(fb,gb).%
liaison(fc,fd).%
liaison(fc,gc).%
liaison(fd,fe).%
liaison(fd,gd).%
liaison(fe,ge).%
liaison(fe,ff).%
liaison(ff,gf).%

liaison(gb,gc).%
liaison(gb,hb).%
liaison(gc,gd).%
liaison(gc,hc).%
liaison(gd,ge).%
liaison(gd,hd).%
liaison(ge,he).%
liaison(ge,gf).%
liaison(hf,gf).%

liaison(hb,hc).%
liaison(hc,hd).%
liaison(hd,he).%

liaison(hd,id).%
liaison(he,ie).%
liaison(he,hf).%
liaison(id,ie).%

sokoban(ChSol):-sokoban(gd,[dc,fc],[gb,gc],[],42,ChSol).

liaison2(X,Y):-liaison(X,Y).
liaison2(X,Y):-liaison(Y,X).

/* on ne cherche qu'à savoir si un chemin existe entre D et A*/
chemin(A,A,V,CA):-!.
chemin(D,A,V,CA):-liaison2(D,X),not(member(X,CA)),not(member(X,V)),chemin(X,A,[D|V],CA),affichage(D,X),!.
chemin(D,A,CA):-chemin(D,A,[],CA).
/*chemin(A,A).*/
/*affichage(D,A):-write(D),write('->'),write(A),write('\n').*/
affichage(D,A).

/* 
sokoban(caisses,cibles)
CJ : coups joues 
P : position pousseur de caisses
ProfMax : profondeur de recherche maximale
*/
													
/*	
*/								
aff(P1,P2):-write('P='),write(P1),write(' C='),write(P2),write('\n').
/*
on prend une caisse C
on cherche une liaison P1
on cherche l'opposé de la liaison P2
on cherche un chemin de P à P1
on déplace P à C, puis C à P2
on recommence
*/

/* on cherche (pour une ligne) : P1-C-P2 */
oppose(C,P1,P2):-liaison2(C,P2),P2\=P1,(ligne(P1,P2);colonne(P1,P2)).
/* si X1 et X2 sont sur la même ligne */
ligne(P1,P2):-name(P1,[X11|X1]),name(P2,[X21|X2]),X11=X21.
colonne(P1,P2):-name(P1,[X11|[X12|X1]]),name(P2,[X21|[X22|X2]]),X12=X22.

oppose2(C,P1,P2):-liaison2(C,P2),liaison2(C,P1),P2\=P1,(ligne(P1,P2);colonne(P1,P2)).



:-dynamic(level/3).
sokoban(P,CA,CI,CJ,ProfMax,ChSol):-retractall(level(_,_,_)),assert(level(0,P,CA)),
							iterDev(0,P,CA,CI,CJ,ProfMax,Res),
							Res==ok,
							retrace(CI,ChSol),
							editSol(ChSol).
							
iterDev(I,_,_,_,_,ProfMax,nonok):-I>=ProfMax,!. /***on a atteint la borne***/
iterDev(I,P,CA,CI,CJ,ProfMax,Res):-devLev(I,CI,CJ,R),
	((R==ok,Res=ok,!);
	 (I1 is I+1,iterDev(I1,P,CA,CI,CJ,ProfMax,Res))
	).

devLev(I,CI,CJ,ok):- I1 is I+1,
			level(I,P,CA),	/***pour tous les etats du niveau i***/
		
			member(C,CA), 	/***sucesseur***/
			liaison2(C,P1), oppose(C,P1,P2), chemin(P,P1,CA), 	/***sucesseur***/
			select(C,CA,CA2),
			sort([P2|CA2],CA2T),	  %tri de CA2
			not(member(CA2T,CJ)), %test si configuration déjà jouée
			
			not(dejavu(C,CA2T)),assert(level(I1,C,CA2T)),
			permutation(CA2T,CI). /***on arrete si on trouve le but***/
devLev(_,_,_,nonok).

dejavu(P,CA):-level(_,X,Y),egal(X,P),egal(Y,CA).

egal(X,X).

retrace(CI,[[P,CI]|ChSol]):-level(I,P,CA),permutation(CI,CA),retrace(P,CA,I,ChSol).

retrace(P,CA,0,[]). % fin de la remontée
retrace(P,CA,I,[[X,Y]|Sol]):-I\=0,I1 is I-1,level(I1,X,Y),
						member(P,Y),select(P,Y,Y2),select(Z,CA,CA2),
						CA2=Y2,
						retrace(X,Y,I1,Sol).



editSol(Sol):-write(Sol).



ttt :- 
	open(sol,write,OS),
   sokoban(ChSol),
   write(OS,ChSol),
   halt.

:- ttt.




/*SOL 


[he, [hd, [gb, ge, gf, he]], [gd, [gb, ge, gf, hd]], [fd, [gb, gd, gf, hd]], [ed, [fd, gb, gf, hd]], [dd, [ed, gb, gf, hd]], [dc, [dd, gb, gf, hd]], [gc, [dc, gb, gf, hd]], [hc, [dc, gc, gf, hd]], [dd, [dc, gf, hc, hd]], [dc, [dd, gf, hc, hd]], [ge, [dc, gf, hc, hd]], [gd, [dc, ge, hc, hd]], [gc, [dc, gd, hc, hd]], [cc, [dc, gc, hc, hd]], [cd, [cc, gc, hc, hd]], [dd, [cd, gc, hc, hd]], [ed, [dd, gc, hc, hd]], [fd, [ed, gc, hc, hd]], [fe, [fd, gc, hc, hd]], [gd, [fe, gc, hc, hd]], [fd, [fe, gc, gd, hc]], [ed, [fd, fe, gc, hc]], [dd, [ed, fe, gc, hc]], [dc, [dd, fe, gc, hc]], [gd, [dc, fe, gc, hc]], [hd, [dc, fe, gd, hc]], [cc, [dc, fe, hc, hd]], [cd, [cc, fe, hc, hd]], [dd, [cd, fe, hc, hd]], [ed, [dd, fe, hc, hd]], [fd, [ed, fe, hc, hd]], [fc, [fd, fe, hc, hd]], [gd, [fc, fe, hc, hd]], [fd, [fc, fe, gd, hc]], [ed, [fc, fd, fe, hc]], [dd, [ed, fc, fe, hc]], [dc, [dd, fc, fe, hc]], [hd, [dc, fc, fe, hc]], [gd, [dc, fc, fe, hd]]]

*/
