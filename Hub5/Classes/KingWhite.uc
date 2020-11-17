class KingWhite extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = true;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skking_whiteMesh'
}
