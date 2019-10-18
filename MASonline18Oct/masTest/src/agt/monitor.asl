// Agent monitor in project masTest

/* Initial beliefs and rules */

/* Initial goals */



/* Plans */

+!monitor: start[source(ethicalEvaluator)] <- .print("Monitoring").
+say(V)[source(ethicalEvaluator)]:true<- .print(V);.send(employee,tell,note(V)).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }


