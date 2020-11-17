class baseFEPage extends UWindowDialogClientWindow;

var baseFEBook book;

function string GetLocalizedString(string id,optional out string tip)
{

	tip=Localize( "help", id,"HPMenu");
	return(Localize( "text", id,"HPMenu" ));	//resume game. utb	"Return to Game";

}


function Paint(Canvas canvas,float x,float y)
{

}

	//called by the FEBook.changePage right before the page is displayed.
function PreSwitchPage()
{
}

function PreOpenBook()
{

}

//-----------------------------------------------------------------------------------------------
// Message box code ....
//-----------------------------------------------------------------------------------------------

function HPMessageBox doHPMessageBox(string msg, string textButton1, optional string textButton2, optional float timeOut)
{
	local HPMessageBox w;
	
	w = HPMessageBox(Root.CreateWindow(class'HPMessageBox', (640-246)/2, (480-102)/2, 246, 102, Self));
	w.Setup (msg, textButton1, textButton2, timeOut);

	root.ShowModal(w);

	return w;
}

function WindowEvent(WinMessage Msg, Canvas C, float X, float Y, int Key) 
{
	if(Msg == WM_Paint || !root.WaitModal())
		Super.WindowEvent(Msg, C, X, Y, Key);
}




//***********************************************************************************************
function bool KeyEvent( byte/*EInputKey*/ Key, byte/*EInputAction*/ Action, FLOAT Delta )
{
	return false;
}

defaultproperties
{
}
