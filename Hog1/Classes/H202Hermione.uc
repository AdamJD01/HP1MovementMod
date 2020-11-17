class H202Hermione extends baseChar;
function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('breathe', 1.0, 0.0);
}
auto state idle{
begin:
loop:
	LoopAnim('breathe', 1.0, 0.0);
	finishanim();
	goto 'loop';
}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhermioneMesh'
     CollisionHeight=42
}
