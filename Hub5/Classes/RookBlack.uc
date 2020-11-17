class RookBlack extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = false;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skrook_blackMesh'
}
