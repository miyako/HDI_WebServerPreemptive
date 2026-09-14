//%attributes = {}
C_TEXT:C284($xmlDoc; $xmlElement; txtValue)

txtValue:=$1


If (WEB Is server running:C1313)
	WEB STOP SERVER:C618
	
	DELAY PROCESS:C323(Current process:C322; 10)
End if 


$xmlDoc:=DOM Parse XML source:C719(Get 4D file:C1418(3))
$xmlElement:=DOM Find XML element:C864($xmlDoc; "preferences/com.4d/web/standalone_server/options/web_processes")
DOM SET XML ATTRIBUTE:C866($xmlElement; "preemptive"; txtValue)
DOM EXPORT TO FILE:C862($xmlDoc; Get 4D file:C1418(3))
DOM CLOSE XML:C722($xmlDoc)

WEB START SERVER:C617