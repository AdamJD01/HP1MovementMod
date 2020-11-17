class spellTrigger extends trigger;

//var(Obsolete) Class<baseSpell> spellType;
var(trigger) name spellName;
var(trigger) bool bHackTriggerOnceOnly;
//
// See whether the other actor is relevant to this trigger.
//

function BeginPlay() {


	// Set spellName based on eVulnerableToSpell
	spellName = SelectSpell( eVulnerableToSpell );

	// Log("***** MySpellTrigger::BeginPlay    spellName = " $ spellName );

	Super.BeginPlay();
}


function name SelectSpell(ESpellType Spell)
{

	switch(Spell)
	{

		case SPELL_None:
			return 'spellnone';
			break;
		case SPELL_Alohomora:
			return 'spellAloho';
			break;
		case SPELL_Incendio:
			return 'spellIncendio';
			break;
		case SPELL_LocomotorWibbly:
			return 'spellAloho';
			break;
		case SPELL_Lumos:
			return 'spelllumas';
			break;
		case SPELL_Nox:
			return 'spellAloho';
			break;
		case SPELL_PetrificusTotalus:
			return 'spellAloho';
			break;
		case SPELL_WingardiumLeviosa:
			return 'spellLev';
			break;
		case SPELL_WingSustain:
			return 'spellPostLev';
			break;
		case SPELL_Verdimillious:
			return 'spellVerd';
			break;
		case SPELL_Vermillious:
			return 'spellAloho';
			break;
		case SPELL_Flintifores:
			return 'spellFlint';
			break;
		case SPELL_Reparo:
			return 'spellRepairo';
			break;
		case SPELL_MucorAdNauseum:
			return 'spellAloho';
			break;
		case SPELL_Flipendo:
			return 'spellFlip';
			break;
		case SPELL_Ectomatic:
			return 'spellEcto';
			break;
		case SPELL_Avifores:
			return 'spellAvif';
			break;
		case SPELL_FireCracker:
			return 'spellFireCracker';
			break;
	}
}


function bool IsRelevant( actor Other )
{
	if( !bInitiallyActive )
	{
		if(baseSpell(other)==None)
		{
			bInitiallyActive=true;
			log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111making active1 "$other);
			return(false);
		}
		if(other.IsA(spellName))
			return(false);
		else
		{
			bInitiallyActive=true;
			log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11111making active 2 "$other);
			return(false);
		}

		return false;

	}

	//only spells trip this trigger.
	if(baseSpell(other)==None)
		return(false);

	if(other.IsA(spellName))
		return(true);
	else
		return(false);

}

function Touch( actor Other )
{
	local actor A;
	if( IsRelevant( Other ) )
	{
		if( bTriggerOnceOnly )
		{
			// Ignore future touches.
			SetCollision(False);
			bProjTarget = false;
		}
	}

	super.Touch(Other);
}

state() OtherTriggerToggles
{
	function Trigger( actor Other, pawn EventInstigator )
	{
		Super.Trigger(Other, EventInstigator);
		bProjTarget = !bProjTarget;
	}
}

// Other trigger turns this on.
state() OtherTriggerTurnsOn
{
	function Trigger( actor Other, pawn EventInstigator )
	{
		Super.Trigger(Other, EventInstigator);
		bProjTarget = true;
	}
}

// Other trigger turns this off.
state() OtherTriggerTurnsOff
{
	function Trigger( actor Other, pawn EventInstigator )
	{
		Super.Trigger(Other, EventInstigator);
		bProjTarget = false;
	}
}

defaultproperties
{
     TriggerType=TT_Shoot
     bProjTarget=True
}
