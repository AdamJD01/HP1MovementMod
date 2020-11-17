class BathroomHermione extends Hermione;

auto state idle
{
	begin:
	loop:
		if(frand() < 0.9)
		{
			PlayAnim('shiver1');
			finishanim();	
			PlayAnim('trans2shiver2');
			finishanim();	
			PlayAnim('shiver2');
		}
		else
			PlayAnim('shiver2');

		finishanim();	
		goto 'loop';

}

defaultproperties
{
}
