class baseNarrator expands actor;

var baseDialog CurDialog;
var baseDialog CurEmotes;
var globalconfig string	CurLanguageName;

event Spawned()
{
	if(CurLanguageName=="")
		SetLanguage("ENGLISH");
	else
		SetLanguage(CurLanguageName);

//	SetLanguage("");
}

function LoadDialogObject()		//defined in derived class.
{
	Log("Invalid use of baseNarrator");
}

exec function SetLanguage(string name)
{
	CurLanguageName=caps(name);
	SaveConfig();
	LoadDialogObject();
}

function bool FindDialog(string dialogID,out sound dlgSound,out string dlgText)
{
	return(CurDialog.FindDialog(dialogID,dlgSound,dlgText));
}
function float DeliverDialog(string dialogName)
{
	return(CurDialog.DeliverDialog(dialogName));
}
function bool FindEmote(string dialogID,out sound dlgSound)
{
local string dlgText;
	
	return(FindDialog(dialogID,dlgSound,dlgText));

}
function float DeliverEmote(string dialogName)
{
local float duration;
local sound dlgSound;
local string dlgText;


	FindDialog(dialogName,dlgSound,dlgText);

	if(dlgSound!=None)
		{
		duration=GetSoundDuration(dlgSound);
		duration+=0.5;		//a little space between sounds.
		PlaySound(dlgSound,SLOT_Interact, 3.2, false, 20000.0, 1.0);
		}
	return(duration);
}

defaultproperties
{
     CurLanguageName="ENGLISH"
     bHidden=True
}
