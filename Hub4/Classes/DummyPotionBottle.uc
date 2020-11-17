// Dummy Potion Bottle - The Wrong for the Potion Puzzle at the end of the game
//	author:  Paul J. Furio


class DummyPotionBottle extends baseChar;


var vector NewLocation;
var actor potionparticle;
var bool ChangedToBlue;

// *** Handle Harry casting spells at the Bottle ***
function bool TakeSpellEffect(baseSpell spell)
{
	local PotionPuzzleControler Controler;
	local baseHarry playerHarry;

	foreach allActors(class'PotionPuzzleControler', Controler)
	{
		break;
	}

	foreach AllActors(class'baseHarry', playerHarry)
	{
		break;
	}

	if((Controler.nComplexityLevel > 1)&&(Controler.nComplexityLevel < 7))  // Do nothing until a swap
	{
		if(spell.class==class'spellflip')
		{

//			playSound(sound'HPSounds.magic_sfx.spell_hit');
			TriggerEvent( 'PotionLose', self, None );

			// AE:
			gotostate( 'DrinkingPotion' );

			playerHarry.clientmessage("Dummy Potion Bottle hit.  Harry Dies...");

			// Go to the "Oops, I drank Lye" cutscene...
		}
		else
			super.TakeSpellEffect(spell);
	}
}

// AE:
// This is a bit or a hack. If these samples can be moved somewhere else, please do!
state DrinkingPotion
{
begin:

	Sleep( 10 );

	switch( Rand(4) )
	{
		case 0:	playSound(sound'HPSounds.Har_emotes.wipe_mouth1'); break;
		case 1:	playSound(sound'HPSounds.Har_emotes.wipe_mouth2'); break;
		case 2:	playSound(sound'HPSounds.Har_emotes.wipe_mouth3'); break;
		case 3:	playSound(sound'HPSounds.Har_emotes.wipe_mouth4'); break;
	}

	Sleep( 4 );
	
	switch( Rand(2) )
	{
		case 0:	playSound(sound'HPSounds.HAR_emotes.potion_bad1'); break;
		case 1:	playSound(sound'HPSounds.HAR_emotes.potion_bad2'); break;
	}
}

state Bottleflash
{
begin:
	if(!ChangedToBlue)
	{
		playSound(sound'HPSounds.magic_sfx.spawn_flash');
		potionparticle=spawn(class'potion_flash',self,,Location);
		Sleep(1);
		Mesh=Mesh'PotionBottleBlueMesh';
		Sleep(0.5);
		ChangedToBlue = true;
		potionparticle.destroy();
	}
	gotostate('PotionIdle');
}

auto state PotionIdle
{
begin:

loop:
	Sleep(1);
	goto('loop');
}

state MoveToNewLocation
{
begin:
	moveto(NewLocation);

loop:
	Sleep(1);
	gotostate('PotionIdle');
}

defaultproperties
{
     bFlipTarget=True
     bGestureOnTargeting=False
     GroundSpeed=600
     AccelRate=800
     Physics=PHYS_Walking
     eVulnerableToSpell=SPELL_Flipendo
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottleBlueMesh'
     AmbientGlow=200
     CollisionRadius=8
     CollisionHeight=12
     bProjTarget=True
}
