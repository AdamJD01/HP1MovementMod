class Tut3Hermione extends basechar;


state SpellLesson
{
	begin:
//		playanim('alolessonstart');
//		finishanim();
		playanim('alolesson',2.5,0.5);
		finishanim();
//		playanim('alolessonend');
//		finishanim();
		gotostate('idle');
}

state idle
{
begin:
	LoopAnim('Breathe',,0.5);
}

defaultproperties
{
     GroundSpeed=150
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhermioneMesh'
}
