//%attributes = {"publishedWeb":true,"preemptive":"capable"}
C_TEXT:C284($1)

C_TEXT:C284($filePath; $fileName)

$fileName:=Substring:C12($1; 2)

$filename:=Replace string:C233($filename; "/"; Folder separator:K24:12)
$filename:=Replace string:C233($filename; " "; "_")

$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+$fileName

WEB SEND FILE:C619($filePath)