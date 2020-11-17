class H202Ron extends baseChar;
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
     PeripheralVision=1
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skronMesh'
     CollisionHeight=42
}
