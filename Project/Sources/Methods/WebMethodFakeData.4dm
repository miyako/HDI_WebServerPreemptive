//%attributes = {"publishedWeb":true,"invisible":true}
#DECLARE($urlPath : Text)

// Make a loop with many computing operations
For ($i; 1; 30000)
	$var:=258
	
	$res:=Cos:C18($var)
	$res:=Sin:C17($var)
	$res:=Tan:C19($var)
	$res:=Arctan:C20($var)
	$res:=Dec:C9($var)
	$res:=Mod:C98($var; 2)
	$res:=Abs:C99($var)
	$res:=Trunc:C95($var; 1)
	$res:=Round:C94($var; 1)
	$res:=Exp:C21($var)
	$res:=Log:C22($var)
	$res:=Square root:C539($var)
	$res:=$var*$var
	$res:=$var+$var
	$res:=$var*$var*$var
	
End for 

WEB SEND FILE:C619(Get 4D folder:C485(Current resources folder:K5:16)+"fake_data.png")