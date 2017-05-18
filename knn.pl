%%
dist([],[],0).
dist([X|Xs],[X|Ys],N) :- !,dist(Xs,Ys,N).
dist([_|Xs],[_|Ys],N) :-
dist(Xs,Ys,M), N is M+1.
sumClass([],[]).
sumClass([N-C|Ls],[S-C|R]) :- sumOneClass(C,[N-C|Ls],Lo,S), sumClass(Lo,R).
sumOneClass(C,Li,Lo,S):-selClass(C,Li,Co,Lo),zipper(Co,Ns,Cs),length(Ns,S).
selClass(X,L,[No-X|Co],Lo) :-select(No-X,L,L1),selClass(X,L1,Co,Lo).
selClass(X,L,[],L).
sumClassW([],[]).
sumClassW([N-C|Ls],[S-C|R]) :- sumOneClassW(C,[N-C|Ls],Lo,S), sumClassW(Lo,R).
sumOneClassW(C,Li,Lo,S):-selClass(C,Li,Co,Lo),zipper(Co,Ns,Cs),
maplist(funcw,Ns,Nsw),sumlist(Nsw,S).
funcw(X, 1/(1+X*X) ).
%%
zipper([(X-Y)|XYs],[X|Xs],[Y|Ys]):-!,zipper(XYs,Xs,Ys).
zipper([],[],[]).
max(L,M):-msort(L,Lo),last(Lo,M).
first(K,L,KL):-length(KL,K),append(KL,_,L).
