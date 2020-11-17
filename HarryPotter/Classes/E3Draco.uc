class E3Draco extends baseChar;
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
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skdracoMesh'
}
