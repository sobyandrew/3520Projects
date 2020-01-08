hopReturn(Net,Alpha,Oldo,Oldo) :- Net == Alpha, !.
hopReturn(Net,Alpha,_,1.0) :- Net > Alpha, !.
hopReturn(Net,Alpha,_,-1.0) :- Net < Alpha, !.

hop11Activation(Net,Alpha,Oldo,Output) :-
  hopReturn(Net,Alpha,Oldo,Output).

/* netUnit*/
netUnit([],[],0.0).
netUnit([H1|T1],[H2|T2],Net) :-
  netUnit(T1,T2, New),
  Net is ((H1 * H2) + New),!.

/*netAll(State,Weights,NetEntire)*/

netAll(_,[],[]).
netAll(State, [H1|T1], [H2|T2]):-
  netUnit(State, H1, H2),
  netAll(State,T1,T2),!.

/*nextState(+CurrentState, +WeightMatrix, +Alpha, -Net)*/

nextStateHelper([],[],_,[]).
nextStateHelper([H1|T1],[H2|T2],Alpha,[H3|T3]):-
  hop11Activation(H1,Alpha,H2,H3),
  nextStateHelper(T1,T2,Alpha,T3), !.

nextState([H1|T1],[W|W2], Alpha, Net):-
  netAll([H1|T1], [W|W2], Result),
  nextStateHelper(Result , [H1|T1], Alpha, Net), !.

updateN(CurrentState,_,_,0,CurrentState).
updateN(CurrentState,WeightMatrix, Alpha, N, Result):-
  nextState(CurrentState, WeightMatrix, Alpha, NewState),
  Next is (N-1),
  updateN(NewState,WeightMatrix,Alpha,Next,Result), !.

setHelp(A,B):- B is A, !.

hopHelpIn([],_,_,_,[]).

hopHelpIn([_|T1],State,Val1, Val2,[0.0|T2]):-
  Val1 == Val2,
  setHelp((Val2 + 1),Next),
  hopHelpIn(T1,State,Val1,Next,T2),!.

hopHelpIn([H1|T1],State,Val1, Val2,[H2|T2]):-
  setHelp((H1*State),H2),
  setHelp((Val2 + 1),Next),
  hopHelpIn(T1, State, Val1,Next, T2),!.


hopHelpOut(_,[],_,[]).

hopHelpOut(State,[H1|T1],Val1, [W1|W2]):-
  hopHelpIn(State,H1,Val1, 0 , W1),
  setHelp((Val1 + 1),Next),
  hopHelpOut(State, T1, Next, W2),!.


hopTrainAstate(State,W):-
  hopHelpOut(State,State,0,W).


addListNext([],[],[]).
addListNext([H1|T1],[H2|T2],[H3|T3]):-
  setHelp((H1+H2), H3),
  addListNext(T1,T2,T3), !.

/*addList([],[],[]).*/
/*Added this*/
addList([H1|[]],[H2|[]],[H3|[]]):-
  addListNext(H1,H2,H3), !.
addList([H1|T1],[H2|T2],[H3|T3]):-
  addListNext(H1,H2,H3),
  addList(T1,T2,T3), !.


/*callNext([H1|T1],H1):- T1 = [].*/
/*Added This*/
callNext([H1|[]],H1).
callNext([H1,H2|T1], W):-
  addList(H1,H2,NewList),
  callNext([NewList|T1],W),!.


/*callAstate([],[]).*/
/*added this*/
callAstate([H1|[]],[H2|[]]):-
  hopTrainAstate(H1,H2),!.
callAstate([H1|T1],[H2|T2]):-
  hopTrainAstate(H1,H2),
  callAstate(T1,T2),!.

hopTrain(States,Weights):-
  callAstate(States, Return),
  callNext(Return, Weights),!.
