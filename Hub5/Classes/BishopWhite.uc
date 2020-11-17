class BishopWhite extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = true;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skbishop_whiteMesh'
}
