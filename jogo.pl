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
%% Verifica se empatou 
complete(XO,T) :- member(X,[1,2,3,4,5,6,7,8,9]),emptyPos(X,T),setMov(X,T,XO),!,complete(XO,T).
complete(XO,T).
tie(T):- complete(o,T),\+ win(T,_),!,complete(x,T),\+ win(T,_).

testOK(P,Tab) :- emptyPos(P,Tab), arg(P,Tab, 'x'),!; 
				write('Tentativa inválida, tente outra vez'),nl,chooseMov(Tab,enemy).
chooseMov(T, enemy):- write('jogue (1..9):'),nl,read(P), testOK(P,T).
chooseMov(T, computerEnemy):- 
	threat(T,playerO,W),!,setMov(W,T,o),!;
	threat(T,playerX,W),!,setMov(W,W,o),!;
	emptyPos(5,T),setMov(5,T,'o'),!;
	guess(9,W),member(W,[1,2,7,9]),emptyPos(W,T),setMov(W,T,'o'),!;
	guess(9,W),member(W,[2,4,6,8]),emptyPos(W,T),setMov(W,T,'o'),!.

threat(Tab,CB,W) :- line(Position),threat(CB,Position,Tab,W),!.
threat(playerX,[A,B,C],T,A) :- emptyPos(A,T),playerX(B,T),playerX(C,T).
threat(playerX,[A,B,C],T,B) :- emptyPos(B,T),playerX(A,T),playerX(C,T).
threat(playerX,[A,B,C],T,C) :- emptyPos(C,T),playerX(C,T),playerX(B,T).
threat(playerO,[A,B,C],T,A) :- emptyPos(A,T),playerO(B,T),playerO(C,T).
threat(playerO,[A,B,C],T,B) :- emptyPos(B,T),playerO(A,T),playerO(C,T).
threat(playerO,[A,B,C],T,C) :- emptyPos(C,T),playerO(A,T),playerO(B,T).

drawLine(A,B,C,T):-arg(A,T,V1), drawColumn(V1),write('|'),
arg(B,T,V2), drawColumn(V2),write('|'),
arg(C,T,V3), drawColumn(V3),nl.
drawColumn(A):- var(A)->write(' ');write(A).
drawTab(T) :- nl, tab(7),drawLine(1,2,3,T), tab(7),write('------'),nl,
tab(7),drawLine(4,5,6,T), tab(7),write('------'),nl,
tab(7),drawLine(7,8,9,T).nl.

start :- T = tab(A,B,C,D,E,F,G,H,I),drawTab(T,begin),play(T,player).
play(T,Player):- chooseMov(T,Player),!,drawTab(T,Player),!,play(T,Jogador)
