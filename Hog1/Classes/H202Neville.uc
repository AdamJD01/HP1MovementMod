class H202Neville extends baseChar;
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
     idleAnimName=None
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.sknevilleMesh'
     CollisionHeight=42
}
