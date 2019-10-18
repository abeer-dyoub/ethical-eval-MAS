/* ==================================================================================== */
/* ========very simple parser to translate sentences into predicate facts======= */
/* ========Then answer questions on the translated information======= */
/* ==================================================================================== */
/* SENTENCE */
/* ==================================================================================== */
s(s(s(NP,VP),CONJ,ST),Sem) --> np(NP,X), vp(VP,Y,_,_T), conj(CONJ,_Conj), s(ST,S),{Sem=..[Y,X,S]}.
s(s(NP,VP),Sem) --> np(NP,X), vp(VP,Y,Z,W,_,_T), 	{Sem=..[Y,X,Z,W]}.
s(s(NP,VP),Sem) --> np(NP,X), vp(VP,Y,Z,_,_T), 		{Sem=..[Y,X,Z]}.
s(s(NP,VP),Sem) --> np(NP,X), vp(VP,Y,_,_T), 		{Sem=..[Y,X]}.

/* ==================================================================================== */
/* QUESTION*/
/* ==================================================================================== */

/* ====================	YES - NO ==================== */ 
q(q(AV,NP,ADJ),	 Sem,tf) --> av(AV,Av,_), np(NP,N), adj(ADJ,Adj), {av(Av,1), Sem=..[Adj,N]}.

q(q(AV,NP,V),	 Sem,tf) --> av(AV,Av,T), np(NP,N), iv(V,Verb,2,T), {av(Av,1), Sem=..[Verb,N]}.
q(q(AV,NP,V),	 Sem,tf) --> av(AV,Av,T), np(NP,N), iv(V,Verb,3,T), {av(Av,2), Sem=..[Verb,N]}.
q(q(AV,NP,V,ADV),Sem,tf) --> av(AV,Av,T), np(NP,N), iv(V,Verb,2,T), adv(ADV,Adv), {av(Av,1), Sem=..[Verb,N,Adv]}.
q(q(AV,NP,V,ADV),Sem,tf) --> av(AV,Av,T), np(NP,N), iv(V,Verb,3,T), adv(ADV,Adv), {av(Av,2), Sem=..[Verb,N,Adv]}.

q(q(AV,NP,V,NP2),Sem,tf) --> av(AV,Av,T), np(NP,N), tv(V,Verb,2,T), np(NP2,N2), {av(Av,1), Sem=..[Verb,N,N2]}.
q(q(AV,NP,V,NP2),Sem,tf) --> av(AV,Av,T), np(NP,N), tv(V,Verb,3,T), np(NP2,N2), {av(Av,2), Sem=..[Verb,N,N2]}.

/* ====================	What questions ==================== */

% questions with 3 arguments
q(q(QW,AV,NP1,V,NP2,PREP), X,wh) --> qw(QW,_Qw), av(AV,_Av,T), np(NP1,N1), tv(V,Verb,_,T), np(NP2,N2), prep(PREP,_Prep),	
{Sem=..[Verb,N1,N2,X],Sem}.
q(q(QW,AV,NP1,V,NP2,PREP), X,wh) --> qw(QW,_Qw), av(AV,_Av,T), np(NP1,N1), tv(V,Verb,_,T), prep(PREP,_Prep), np(NP2,N2),	
{Sem=..[Verb,N1,X,N2],Sem}.
q(q(QW,V,NP1,PREP,NP2),    X,wh) --> qw(QW,_Qw), tv(V,Verb,1,_T), np(NP1,N1), prep(PREP,_Prep), np(NP2,N2), 				
{Sem=..[Verb,X,N1,N2],Sem}.


q(q(QW,V,ADV),	 X,wh) 	--> qw(QW,_Qw), iv(V,Verb,1,_), adv(ADV,Adv),{Sem=..[Verb,X,Adv],Sem}.
q(q(QW,V,NP),	 X,wh) 	--> qw(QW,_Qw), iv(V,Verb,1,_), np(NP,N),{Sem=..[Verb,X,N],Sem}.
q(q(QW,V,NP),	 X,wh) 	--> qw(QW,_Qw), tv(V,Verb,1,_), np(NP,N),{Sem=..[Verb,X,N],Sem}.
q(q(QW,V),X,wh) 	--> qw(QW,_Qw), iv(V,Verb,1,_), {Sem=..[Verb,X],Sem}.

q(q(QW,AV,V),	   X,wh)--> qw(QW,_Qw), av(AV,Av,T), 	iv(V,Verb,2,T), {av(Av,1), Sem=..[Verb,X],Sem}.
q(q(QW,AV,V,ADV),  X,wh)--> qw(QW,_Qw), av(AV,Av,T), 	iv(V,Verb,2,T), adv(ADV,Adv),{av(Av,1), Sem=..[Verb,X,Adv],Sem}.
q(q(QW,AV,NP,V),   X,wh) --> qw(QW,_Qw), av(AV,Av,T), 	np(NP,N), 	tv(V,Verb,3,T),	{av(Av,2), Sem=..[Verb,N,X],Sem}.
q(q(QW,AV,ADJ),    X,wh)  --> qw(QW,_Qw), av(AV,Av,_), 	adj(ADJ,Adj),	{av(Av,1), Sem=..[Adj,X],Sem}.
q(q(QW,V,CONJ,ST), X,wh) --> qw(QW,_Qw), iv(V,Verb,1,_), conj(CONJ,_Conj), s(ST,S),{Sem=..[Verb,X,S],Sem}.

q(q(QW,AV,NP,V), X,wh) 	--> qw(QW,how), av(AV,Av,T),np(NP,N), iv(V,Verb,3,T),	{av(Av,2), adverb(X),Sem=..[Verb,N,X],Sem}.
q(q(QW,AV,NP,V), X,wh) 	--> qw(QW,how), av(AV,Av,T),np(NP,N), iv(V,Verb,2,T),	{av(Av,1), adverb(X),Sem=..[Verb,N,X],Sem}.

q(q(QW,AV,NP,V,PREP), X,wh) --> qw(QW,what), av(AV,Av,T), np(NP,N), iv(V,Verb,2,T), prep(PREP,_Prep), {av(Av,1), Sem=..[Verb,N,X],Sem}.
q(q(QW,AV,V,PREP,NP), X,wh) --> qw(QW,who), av(AV,Av,T), iv(V,Verb,2,T), prep(PREP,_Prep), np(NP,N),  {av(Av,1), Sem=..[Verb,X,N],Sem}.

/* ==================================================================================== */
/* GRAMMAR RULES*/
/* ==================================================================================== */
np(np(PP,DET,NBAR),X2) 	 --> pp(PP,_X1),  det(DET,_Det), nbar(NBAR,X2).	
np(np(PREP,DET,NBAR),X2) --> prep(PREP,_X1), det(DET,_Det), nbar(NBAR,X2).	
np(np(DET,NBAR,PP),X1) 	 --> det(DET,_Det),  nbar(NBAR,X1), pp(PP,_X2).	


np(np(DET,NBAR),X) 	--> det(DET,_Det), nbar(NBAR,X).
np(np(PN),X) 		--> pn(PN,X).
np(np(N),X) 		--> n(N,X).

vp(vp(IV),Iv,C,T)  	--> iv(IV,Iv,C,T).
vp(vp(IV,ADV),Iv,Adv,C,T) --> iv(IV,Iv,C,T), adv(ADV,Adv).
vp(vp(IV,PREP),Iv,Prep,C,T) --> iv(IV,Iv,C,T), prep(PREP,Prep).
vp(vp(IV,ADJ),Iv,Adj,C,T) --> iv(IV,Iv,C,T), adj(ADJ,Adj).
vp(vp(IV,NP),Iv,X,C,T) 	  --> iv(IV,Iv,C,T), np(NP,X).
vp(vp(TV,NP),Tv,X,C,T) 	  --> tv(TV,Tv,C,T), np(NP,X).
vp(vp(AV,ADJ),X,_,T) 	  --> av(AV,Av,T), adj(ADJ,X), {av(Av,1)}.

vp(vp(TV,NP1,PREP,NP2),Tv,X1,X2,C,T) --> tv(TV,Tv,C,T), np(NP1,X1), prep(PREP,_Prep), np(NP2,X2).

vp(vp(AV,IV),Iv,2,T)  	  	--> av(AV,Av,T), iv(IV,Iv,2,T), {av(Av,1)}.
vp(vp(AV,IV,ADV),Iv,Adv,2,T)  	--> av(AV,Av,T), iv(IV,Iv,2,T), adv(ADV,Adv), {av(Av,1)}.
vp(vp(AV,IV,PREP),Iv,Prep,2,T)  --> av(AV,Av,T), iv(IV,Iv,2,T), prep(PREP,Prep), {av(Av,1)}.
vp(vp(AV,IV,PREP,N),Iv,X,1,T)	--> av(AV,Av,T), iv(IV,Iv,1,ps),prep(PREP,_), n(N,X), {av(Av,1)}.
vp(vp(AV,IV,NP),Iv,X,2,T)   	--> av(AV,Av,T), iv(IV,Iv,2,T), np(NP,X), {av(Av,1)}.
vp(vp(AV,TV,NP),Tv,X,2,T)   	--> av(AV,Av,T), tv(TV,Tv,2,T), np(NP,X), {av(Av,1)}.

pp(pp(PREP,NP),Sem) 	--> prep(PREP,Prep), np(NP,X), {Sem=..[Prep,X]}.
pp(pp(DET,NBAR),X) 	--> det(DET,_Det), nbar(NBAR,X).

nbar(nbar(N),Nx) 	--> n(N,Nx).
nbar(nbar(ADJ,NBAR),Sem) --> adj(ADJ,X1), nbar(NBAR,X2), {Sem=..[X1,X2]}.


/* ==================================================================================== */
/*LEXICAL RULES	*/
/* ==================================================================================== */
det(det(X),X)	 -->[X], {determiner(X)}.
conj(conj(X),X)	 -->[X], {conjuction(X)}.
pn(pn(X),X)	-->[X], {pronoun(X)}.
n(n(X),X)	-->[X], {noun(X)}.
adj(adj(X),X)	 -->[X], {adjective(X)}.
iv(iv(X),Vx,C,T) -->[X], {iverb(Vx,C,T,[X],[])}.
tv(tv(X),Vx,C,T) -->[X], {tverb(Vx,C,T,[X],[])}.
av(av(X),X,T)	 -->[X], {averb(X,T)}.
qw(qw(X),X)	-->[X], {qword(X)}.
adv(adv(X),X)	 -->[X], {adverb(X)}.
prep(prep(X),X)	 -->[X], {preparation(X)}.


/* ==================================================================================== */
/*VOCABULARY*/
/* ==================================================================================== */
determiner(X):- member(X, [a, an, the, one, some]).

conjuction(X):- member(X, [that, and, but]).

pronoun(X):- member(X, [product1,product2,product3]).

noun(X):- member(X, [summer, winter,	food, money, market,  day, night,mobile, computer, book, cd, screen,bottle, program]).
					 
adjective(X):- member(X, [thin, good, bad, long,big, small, beautiful, black, blue, white, green, red, orange, purple, yellow, brown, environmentallyFriendly]).
							
qword(X):- member(X, [who,what,how]).

adverb(X):- member(X, [fast, slow, loud, quite, hard, suddenly]).

preparation(X):- member(X, [in, on, of, at, to, behind, before, after, until, back, front, nearby, with, without]).

/* ================== VERBS ================== */
/* ========	  INTRANSITIVE	========= */

iverb(plays,1,pr) -->[plays]. 	
iverb(plays,2,pr) -->[playing].		
iverb(plays,3,pr) -->[play].
iverb(played,1,ps) -->[played]. 	
iverb(played,2,ps) -->[playing].	
iverb(played,3,ps) -->[play].

:-dynamic plays/1.
:-dynamic played/1.

/* ========	  TRANSITIVE	========= */
tverb(has,1,pr)		-->[has]. 	
tverb(has,2,pr) -->[having].	
tverb(has,3,pr) -->[have].
tverb(had,1,ps)	-->[had]. 		
tverb(had,2,ps) -->[having].		
tverb(had,3,ps) -->[have].

:-dynamic has/2.
:-dynamic had/2.


/* ========	  AUXILIARY	========= */
averb(X,pr):- member(X, [is, does]).
averb(X,ps):- member(X, [was, did]).

av(Av,1):- member(Av, [is, was]).
av(Av,2):- member(Av, [does, did]).

/* ==================================================================================== */
/*TOKENIZER*/
/* ==================================================================================== */
tokenize([],[]):- !.					% terminal rule

tokenize(L,[Word|Out]):-
	L\==[],
	tokenize(L,Rest,WordChs),			% recognition of the 1st word 
	name(Word,WordChs),				% convert the chars to a Prolog term 
	tokenize(Rest,Out).				% continue with the rest

tokenize([],[],[]):- !.					% End of word
	tokenize([46|_],[],[]):- !.			% stop = end of sentence
	tokenize([63|_],[],[]):- !.			% Question Mark = end of sentence
	tokenize([32|T],T,[]):- !.			% Space = end of word
	tokenize([44|T],T,[]):- !.			% Comma = end of word

tokenize([H|T],Rest,[H|List]):-			        % if not end of word
	tokenize(T,Rest,List). 				% add char and repeat.
	
/* ==================================================================================== */
/*Read Atom	  				      				      	*/
/* ==================================================================================== */
readAtom(A) :-
	readChars(S),
	name(A,S).

readChars([Char|Rest]):-
   	get0(Char),
  	 Char\=10,!,
   	readChars(Rest).

readChars([]).


/* ==============     ADD   ==================================================== */
/* For parsing a sentence */
/* ============================================================================= */
add :-
	readAtom(X),
	name(X,L),
	tokenize(L,Out),
	s(Structure,Sem,Out,[]),
	asserta(Sem),
	write('The fact '),write(Sem),write(' was added to the KB.'),nl,
	
	
add(X):-
	name(X,L),
	tokenize(L,Out),
	s(Structure,Sem,Out,[]),
	asserta(Sem),
	write('The fact '),write(Sem),write(' was added to the KB.'),nl,
		
		

/* ==============	ASK	================================================ */
/* For asking a question */
/* ============================================================================= */		
ask :-
	readAtom(X),
	name(X,L),
	tokenize(L,Out),
	query(Out).
		
ask(X):-	
	name(X,L),
	tokenize(L,Out),
	query(Out).
		
query(Out):- q(Structure,Sem,tf,Out,[]), (Sem -> write('Answer: YES.') ; write('Answer: NO.')).
query(Out):- q(Structure,Fact,wh,Out,[]), write('Answer: '), write(Fact), nl.


/*============================================================================================================*/
