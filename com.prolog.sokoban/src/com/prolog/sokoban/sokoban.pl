/* niveau 3x3 simple ac, [bb], [ac]
liaison(ba,bb).
liaison(bc,bb).
liaison(bb,cb).
liaison(aa,ba).
liaison(ba,ca).
liaison(ca,cb).
liaison(cb,cc).
liaison(cc,bc).
liaison(bc,ac).
*/
/* niveau 4x4 moins simple aa,[bb,bd],[ac,ad] 
liaison(ba,bb).
liaison(bc,bb).
liaison(bb,cb).
liaison(aa,ba).
liaison(ba,ca).
liaison(ca,cb).
liaison(cb,cc).
liaison(cc,bc).
liaison(bc,ac).
liaison(ac,ad).
liaison(bc,bd).
liaison(cc,cd).
liaison(bd,ad).
liaison(bd,cd).*/

/* niveau 4x4 moins moins simple 
liaison(ba,bb).
liaison(bc,bb).
liaison(bb,cb).
liaison(aa,ba).
liaison(ba,ca).
liaison(ca,cb).
liaison(cb,cc).
liaison(cc,bc).
liaison(bc,ac).
liaison(ac,ad).
liaison(bc,bd).
liaison(cc,cd).
liaison(bd,ad).
liaison(bd,cd).
liaison(aa,ab).
liaison(ab,ac).
liaison(ab,bb).
*/
/*
liaison(aa,ab).
liaison(ab,ac).
liaison(ac,ad).
liaison(ba,bb).
liaison(bc,bb).
liaison(bc,bd).
liaison(cc,cb).
liaison(cc,cd).
liaison(db,dc).
liaison(dd,dc).
liaison(aa,ba).
liaison(bb,ab).
liaison(ac,bc).
liaison(bd,ad).
liaison(bb,cb).
liaison(cc,bc).
liaison(bd,cd).
liaison(cb,dd).
liaison(cc,dc).
liaison(dd,cd).
*/


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

%sokoban:-sokoban(gd,[dc,fd,ce,dc],[gb,gc,ge,gf],[],200).
sokoban:-sokoban(gd,[dc,gc],[gb,gf],[],9).

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

%sokoban:-sokoban(aa,[bb,bc,bd],[ab,ad,dd],[],6).
sokoban(P,CA,CI,CJ,ProfMax):-permutation(CA,CI).
sokoban(P,CA,CI,CJ,ProfMax):-ProfMax>0, member(C,CA), 
							liaison2(C,P1), oppose(C,P1,P2), chemin(P,P1,CA),
							( oppose2(P2,_,_); member(P2,CI) ),
							select(C,CA,CA2),
							sort([P2|CA2],CA2T),	  %tri de CA2
							not(member(CA2T,CJ)), %test si configuration déjà jouée
							ProfMax1 is ProfMax-1,
							sokoban(C,CA2T,CI,[CA2T|CJ],ProfMax1),
							aff(P1,P2),write(CJ),write('\n').
														
/*	
sokoban(P,CA,CI,CJ,ProfMax):- ProfMax\=0,
							member(C,CA), liaison2(C,P1), oppose(C,P1,P2), chemin(P,P1,CA),
							select(C,CA,CA2), 
							sokoban(C,[P2|CA2],CI,[[C,CA2],CJ],ProfMax),
							ProfMax is ProfMax+1,
							aff(P1,P2),write(CJ),write('\n').
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