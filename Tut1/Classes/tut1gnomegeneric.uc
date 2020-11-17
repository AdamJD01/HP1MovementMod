	class tut1gnomegeneric extends tut1gnome;








state stunned
{


function causetrigger()
{

	local actor a;



	foreach AllActors( class 'Actor', A, Event )
	{
		A.Trigger( self, self.Instigator );
	}


}



	begin:
		bprojtarget=false;
		eVulnerableToSpell=SPELL_none;
		//PlaySound(sound 'HPSounds.critters2_sfx.gno_defeated', SLOT_Talk, 3.2, true, 2000.0, 1.0);
		playanim('downdizzy');
		//playanim('downdizzy',[RootBone] 'move');
		finishanim();
			
	loop:
		if(abs(vsize(location-playerharry.location))<200)
		{
		//	PlaySound(sound 'HPSounds.critters2_sfx.gno_defeated', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			playanim('downdizzy');
			//playanim('downdizzy',[RootBone] 'move');
			finishanim();
		}
		
	//	loopanim('downbreath',,[RootBone] 'move');
		loopanim('downbreath');
		sleep (2);
		goto 'loop';



}

defaultproperties
{
     serpentineScale=0
     GroundSpeed=200
     DrawScale=2
     CollisionRadius=30
     CollisionHeight=40
}
