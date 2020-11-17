class hudSpellButton extends UWindowButton;


var hudSpellBook spellBook;
var int spellId;

function click(float x,float y)
{
	if(spellBook!=None)
		{
		if (!bDisabled && (DownSound != None))
			GetPlayerOwner().PlaySound(DownSound, SLOT_Interact);
		spellBook.spellClicked(spellId);
		}	
}

defaultproperties
{
}
