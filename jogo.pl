line([1,2,3]).
line([4,5,6]).
line([7,8,9]).
line([1,4,7]). 
line([2,5,8]).
line([3,6,9]).
line([1,5,9]).
line([3,5,7]).

setMov(N,Tab,C):- arg(N,Tab,C).
enemyX(N,Tab) :- arg(N,Tab,V), nonvar(V), V=x.
enemyO(N,Tab) :- arg(N,Tab,V), nonvar(V), V=o.
emptyPos(N,Tab) :- arg(N,Tab,V), var(V).
fullPos(N,Tab) :- \+ emptyPos(N,Tab).

%% Verifica se alguem venceu
gameOver(T,V) :- win(T,V).
gameOver(T,tiedGame) :- tiedGame(T).
win(T,won(enemyX)) :- line([A,B,C]), enemyX(A,T),enemyX(B,T),enemyX(C,T),!.
win(T,won(enemyO)) :- line([A,B,C]), enemyO(A,T), enemyO(B,T), enemyO(C,T),!.
%% Verifica se empatou 
complete(XO,T) :- member(X,[1,2,3,4,5,6,7,8,9]),emptyPos(X,T),setMov(X,T,XO),!,complete(XO,T).
complete(XO,T).
tiedGame(T):- complete(o,T),\+ win(T,_),!,complete(x,T),\+ win(T,_).

testOk(P,Tab) :- emptyPos(P,Tab),arg(P,Tab,'x'),!;
 				  write('Jogada invalida,tente outra!'),nl,
 				  chooseMov(Tab,enemy).

chooseMov(T, enemy):- write('jogue (1..9):'),nl,
 				  		 read(P), testOk(P,T).
 
 chooseMov(T, computerEnemy):-
	  threat(T,enemyO,W),!,setMov(W,T,o),! %% vence
	; threat(T,enemyX,W),!,setMov(W,T,o),! %% defesa
	; emptyPos(5,T),setMov(5,T,'o'),!
	; guess(9,W),member(W,[1,3,7,9]),emptyPos(W,T),setMov(W,T,'o'),!
	; guess(9,W),member(W,[2,4,6,8]),emptyPos(W,T),setMov(W,T,'o'),!.

 %%
 threat(Tab,CB,W) :- line(Pos),threat(CB,Pos,Tab,W),!.
 threat(enemyX,[A,B,C],T,A) :- emptyPos(A,T),enemyX(B,T),enemyX(C,T).
 threat(enemyX,[A,B,C],T,B) :- emptyPos(B,T),enemyX(A,T),enemyX(C,T).
 threat(enemyX,[A,B,C],T,C) :- emptyPos(C,T),enemyX(A,T),enemyX(B,T).
 threat(enemyO,[A,B,C],T,A) :- emptyPos(A,T),enemyO(B,T),enemyO(C,T).
 threat(enemyO,[A,B,C],T,B) :- emptyPos(B,T),enemyO(A,T),enemyO(C,T).
 threat(enemyO,[A,B,C],T,C) :- emptyPos(C,T),enemyO(A,T),enemyO(B,T).

drawLine(A,B,C,T):-arg(A,T,V1), drawColumn(V1),write('|'),
arg(B,T,V2), drawColumn(V2),write('|'),
arg(C,T,V3), drawColumn(V3),nl.
drawColumn(A):- var(A)->write(' ');write(A).
drawTab(T) :- nl, tab(7),drawLine(1,2,3,T), tab(7),write('------'),nl,
tab(7),drawLine(4,5,6,T), tab(7),write('------'),nl,
tab(7),drawLine(7,8,9,T).

start :- T = tab(A,B,C, D,E,F, G,H,I),showGame(T, begin),play(T, enemy).
play(T, Player):- gameOver(T,Result),!,endMessage(Result).
play(T, Player):- chooseMov(T, Player),!,showGame(T, Player),!,nextPlayer(Player, Opponent),!,play(T, Opponent).
nextPlayer(computerEnemy,enemy).
nextPlayer(enemy,computerEnemy).
showGame(T,J):- write('jogou:'),write(J),drawTab(T).
endMessage(X):- write('Game Over'),write(X),nl,nl.
guess(N,S):-repeat, S is random(N).

%%test 
t0(tab(o,o,o, *,*,*, *,*,*)).
t1(tab(o,x,o, x,o,x, o,x,o)).
t2(tab(o,x,o, x,*,x, *,*,*)).

