class E3Goyle extends baseChar;
function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('plot', 1.0, 0.0);
}
auto state idle{
begin:
loop:
	LoopAnim('lookdownhall', 1.0, 0.0);
	finishanim();
	goto 'loop';
}

defaultproperties
{
     idleAnimName=None
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skgoyleMesh'
     DrawScale=1.1
}
