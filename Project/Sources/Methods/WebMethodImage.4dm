//%attributes = {"publishedWeb":true,"preemptive":"capable","invisible":true}
#DECLARE($urlPath : Text)

var $filePath; $fileName : Text

$fileName:=Substring:C12($urlPath; 2)

$filename:=Replace string:C233($filename; "/"; Folder separator:K24:12)
$filename:=Replace string:C233($filename; " "; "_")

$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+$fileName

WEB SEND FILE:C619($filePath)