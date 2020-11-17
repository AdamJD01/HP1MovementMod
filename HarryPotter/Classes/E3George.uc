class E3George extends baseChar;
function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('plot', 1.0, 0.0);
}
auto state idle{
begin:
loop:
	LoopAnim('plot', 1.0, 0.0);
	finishanim();
	goto 'loop';
}

defaultproperties
{
     walkAnimName=trot
     idleAnimName=None
     GroundSpeed=100
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skgeorgeMesh'
}
