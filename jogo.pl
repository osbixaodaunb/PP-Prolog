%% Tentando montar o tabuleiro, comecando da parte de cima
line([1,2,3]).
line([4,5,6]).
line([7,8,9]).
line([1,4,7]). 
line([2,5,8]).
line([3,6,9]).
line([1,5,9]).
line([3,5,7]).

setMov(N,Tab,C):- arg(N,Tab,C).
playerX(N,Tab) :- arg(N,Tab,V), nonvar(V), V=x.
playerO(N,Tab) :- arg(N,Tab,V), nonvar(V), V=o.
emptyPos(N,Tab) :- arg(N,Tab,V), var(V).
fullPos(N,Tab) :- \+ emptyPos(N,Tab).

%% Verifica se alguem venceu
win(T,won(playerX)) :- line([A,B,C]), playerX(A,T),playerX(B,T),playerX(C,T),!.
win(T,won(playerO)) :- line([A,B,C]), playerO(A,T), playerO(B,T), playerO(C,T),!.
