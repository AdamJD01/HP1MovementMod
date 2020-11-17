//===============================================================================
//  [PotionsTeacherCauldron] 
//===============================================================================

class PotionsMasterCauldron extends PotionsTeacherCauldron;

var ParticleFX secondParticle;

event PostBeginPlay()
{
	super.PostBeginPlay();
//	SetTimer(0.7,true);
}

state failed
{
begin:
	//Fizz over
	playerHarry.ReceiveIconMessage(None,"Snape: You failed! Start over.",3.0);
	killAttachedParticleFX(3.0);

loop:
	Sleep(3.0);	//give fizz time to run.
	gotostate ('blueState');

}
state winState
{
begin:
	//Fizz over
	killAttachedParticleFX(6.0);
	Sleep(2.0);	//give harry a chance to animate the pour
		
			//show Poof
	secondParticle=spawn(class'Cauldron_victory',,,location+attachedParticleOffset);
	secondParticle.setRotation(secondParticle.default.rotation);
	Sleep(2.5);	//give Poof a chance to run out

	playerHarry.ReceiveIconMessage(None,"Snape: You did it! You may go now.",3.0);

//	killAttachedParticleFX(3.0);

loop:
	Sleep(30.0);	//give fizz time to run.
	goto 'loop';

}

event bump(actor other)
{
local name curState;

//	playerHarry.clientMessage(other $"bumped me");

	if(playerHarry.quickInventory!=None)
		{
		playerHarry.gotostate('potionPour');
		curState=getStateName();
		if(curState=='winState')
			return;	//already won
		if(curState=='blueState' && playerHarry.quickInventory.isA('PotionBottleBlue'))
			{
			gotostate ('greenState');
			}
		else if(curState=='greenState' && playerHarry.quickInventory.isA('PotionBottleGreen'))
			{
			gotostate ('orangeState');
			}
		else if(curState=='orangeState' && playerHarry.quickInventory.isA('PotionBottleOrange'))
			{
			gotostate ('purpleState');
			}
		else if(curState=='purpleState' && playerHarry.quickInventory.isA('PotionBottlePurple'))
			{
			gotostate ('winState');
			}
		else
			{
			gotostate ('failed');
			}
		playerHarry.quickInventory.destroy();
		playerHarry.quickInventory=None;
		}
}


auto state blueState
{
begin:
	//set particles to blue.
	killAttachedParticleFX(3.0);
	Sleep(3.0);
	changeAttachedParticleFX(class'Cauldron_Blue');
//	playerHarry.clientMessage("In Blue player has "$playerHarry.quickInventory);
loop:
	Sleep(1.0);
	goto 'loop';
}

state greenState
{
begin:
		//start the end of the main particle fx.
	killAttachedParticleFX(4.5);
	Sleep(2.0);	//give harry a chance to animate the pour
		
			//show Poof
	secondParticle=spawn(class'Potion_correct',,,location+attachedParticleOffset);
	secondParticle.setRotation(secondParticle.default.rotation);
	Sleep(2.5);	//give Poof a chance to run out

	//set particles to green.
	changeAttachedParticleFX(class 'Cauldron_Green');
//	playerHarry.clientMessage("In green player has "$playerHarry.quickInventory);
loop:
	Sleep(1.0);
	goto 'loop';
}

state orangeState
{
begin:
		//start the end of the main particle fx.
	killAttachedParticleFX(4.5);
	Sleep(2.0);	//give harry a chance to animate the pour
		
			//show Poof
	secondParticle=spawn(class'Potion_correct',,,location+attachedParticleOffset);
	secondParticle.setRotation(secondParticle.default.rotation);
	Sleep(2.5);	//give Poof a chance to run out

	//set particles to orange.
	changeAttachedParticleFX(class 'Cauldron_Orange');
loop:

	Sleep(1.0);
	goto 'loop';
}

state purpleState
{
begin:
		//start the end of the main particle fx.
	killAttachedParticleFX(4.5);
	Sleep(2.0);	//give harry a chance to animate the pour
		
			//show Poof
	secondParticle=spawn(class'Potion_correct',,,location+attachedParticleOffset);
	secondParticle.setRotation(secondParticle.default.rotation);
	Sleep(2.5);	//give Poof a chance to run out

	//set particles to purple.
	changeAttachedParticleFX(class 'Cauldron_Violet');
loop:
	Sleep(1.0);
	goto 'loop';
}

defaultproperties
{
}
