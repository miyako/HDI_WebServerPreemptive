Case of 
	: (Form event code:C388=On Mouse Move:K2:35)
		
		If (Form event code:C388=On Mouse Move:K2:35)
			SET CURSOR:C469(9000)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($filePath)
		
		$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"coop.png"
		
		OPEN URL:C673($filePath)
		
End case 
