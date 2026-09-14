//%attributes = {"publishedWeb":true,"invisible":true}
#DECLARE($urlPath : Text)

var vName : Text
var vState; vTime; vFlags : Integer
var isVisible; isPreemptive : Boolean
_O_PROCESS PROPERTIES:C336(Current process:C322; vName; vState; vTime; vFlags)
isVisible:=vFlags ?? 0  //true if visible
isPreemptive:=vFlags ?? 1  //true if preemptive

If (isPreemptive=True:C214)
	WEB SEND FILE:C619(Get 4D folder:C485(Current resources folder:K5:16)+"preemptive.png")
Else 
	WEB SEND FILE:C619(Get 4D folder:C485(Current resources folder:K5:16)+"cooperative.png")
End if 
