class BishopBlack extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = false;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skbishop_blackMesh'
}
