// Magic Potion Bottle - The Bottle for the Potion Puzzle at the end of the game
//	author:  Paul J. Furio

class MagicPotionBottle extends DummyPotionBottle;

var bool bEmitParticles;	// toggle this for effects
var bool bParticlesActive;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	if(bEmitParticles)
	{
		potionparticle=spawn(class'potion_sparkle');
		bParticlesActive=true;
	}
}

function Tick(float DeltaTime)
{
	if((bEmitParticles)&&(!bParticlesActive))
	{
		potionparticle=spawn(class'potion_sparkle');
		bParticlesActive=true;
	}
	else if((!bEmitParticles)&&(bParticlesActive))
	{
		potionparticle.destroy();
		bParticlesActive = false;
	}

	Super.Tick(DeltaTime);
}

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
			playSound(sound'HPSounds.magic_sfx.spell_trace_correct');

			if(Controler.nComplexityLevel == 6)
			{

				TriggerEvent( 'PotionWin', self, None );
				playerHarry.clientmessage("Win Potion Puzzle:  Make Harry Icy...");

				// AE:
				gotostate( 'DrinkingPotion' );

				Controler.FinishGame();	// Another Dumb Cheat
			}
			else
			{
				playerHarry.clientmessage("Retriggering Controller...");
				Controler.Trigger( Controler ,self);
			}
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
}

defaultproperties
{
     bEmitParticles=True
     bParticlesActive=True
}
