class H202Draco extends baseChar;
function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('breath', 1.0, 0.0);
}
auto state idle{
begin:
loop:
	LoopAnim('breath', 1.0, 0.0);
	finishanim();
	goto 'loop';
}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skdracoMesh'
     CollisionHeight=42
}
