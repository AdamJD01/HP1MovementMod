//===============================================================================
//===============================================================================

class MirrorInnerBoxObj extends baseChar;

//******************************************************************************************
var Mirror  _Mirror;

//******************************************************************************************
function Tick(float dtime)
{
	//playerHarry.ClientMessage("loc:"$Location);
	SetRotation( _Mirror.Rotation );
}

//******************************************************************************************
function PostBeginPlay()
{
	//Look for our mirror object
	ForEach AllActors(class'Mirror', _Mirror)
		break;

	if( _Mirror == none )
		Log("************** MirrorInnerBoxObj couldn't find Mirror!!");
}

//******************************************************************************************
auto state stateIdle
{
}

//******************************************************************************************
function bool TakeSpellEffect(baseSpell spell)
{
	//playerHarry.ClientMessage("MIBO TakeSpellEffect");
	return _Mirror.TakeSpellEffect(spell);
}

//******************************************************************************************
event Touch(Actor Other)
{
	//playerHarry.ClientMessage("MIBO Touch:"$Other);
	if( spellVoldemortStraight(Other) != none )
		TakeSpellEffect( baseSpell(Other) );
}

//******************************************************************************************

defaultproperties
{
     bDoesntDestroySpell=True
     Tag=MirrorInnerBoxObj
     eVulnerableToSpell=SPELL_Flipendo
     bEdShouldSnap=True
     bIsKillGoal=False
     CollisionRadius=12
     CollisionWidth=80
     CollisionHeight=104
     CollideType=CT_Box
     bCollideWorld=False
     bProjTarget=True
}
