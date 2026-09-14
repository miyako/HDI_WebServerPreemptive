//%attributes = {"publishedWeb":true,"preemptive":"capable","invisible":true}
#DECLARE($urlPath : Text)

var $jsonString : Text
var $blob : Blob

ALL RECORDS:C47([Country:4])
ORDER BY:C49([Country:4]Name:2; >)

$jsonString:=Selection to JSON:C1234([Country:4])
CONVERT FROM TEXT:C1011($jsonString; "UTF-8"; $blob)
WEB SEND RAW DATA:C815($blob)


