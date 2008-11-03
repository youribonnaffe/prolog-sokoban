:-include('com/prolog/sokoban/sokobanLarg.pl').
liaison(bd,cd).
liaison(bd,be).
liaison(be,bf).
liaison(bf,cf).
liaison(cb,db).
liaison(cb,cc).
liaison(cc,cd).
liaison(cd,dd).
liaison(cf,df).
liaison(db,eb).
liaison(dd,ed).
liaison(dd,de).
liaison(de,ee).
liaison(de,df).
liaison(df,dg).
liaison(dg,eg).
liaison(eb,ec).
liaison(ec,fc).
liaison(ec,ed).
liaison(ed,ee).
liaison(ee,fe).
liaison(eg,fg).
liaison(fc,gc).
liaison(fe,ge).
liaison(fe,ff).
liaison(ff,fg).
liaison(gc,gd).
liaison(gd,ge).

sokoban(ChSol):-sokoban(gc,[cc],[df],[],10,ChSol).
:- open('solution',write,OS), sokoban(ChSol), write(OS,ChSol), halt.
