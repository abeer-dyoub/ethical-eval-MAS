// Agent ethicalEval in project masTest

/* Initial beliefs and rules */

/* Initial goals */
sensetiveSlogan(environmentallyFriendly(product1)).
unethical(X):- sensetiveSlogan(X) & not relevant(X).

/* Plans */

+!evaluate : gooo[source(trans)] <- .print("evaluating");.send(monitor, tell,start).

+say(V)[source(trans)]:unethical(V)<- setValue1(V);.print("unethical answer").
+say(V)[source(trans)]:not unethical(V)<- setValue2(V);.print("ethical answer").
+textVal(V):true<- .send(monitor,tell,say(V)).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }


