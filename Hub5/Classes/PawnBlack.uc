class PawnBlack extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = false;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skpawn_blackMesh'
}
