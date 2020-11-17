class pig extends baseChar;

var rotator rotval;
var vector newloc;
var rotator newrot;

auto state pause
{
}

defaultproperties
{
	DrawType=DT_Mesh
	Mesh=SkeletalMesh'HarryPotter.skpig'
	CollisionHeight=30
	bCollideActors=False
}
