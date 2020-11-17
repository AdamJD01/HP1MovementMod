class RookWhite extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = true;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skrook_whiteMesh'
}
