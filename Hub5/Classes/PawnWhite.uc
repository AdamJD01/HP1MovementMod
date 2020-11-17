class PawnWhite extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = true;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skpawn_whiteMesh'
}
