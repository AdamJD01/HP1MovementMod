class KingBlack extends ChessPiece;

function PostBeginPlay()
{
	bPieceWhite = false;
	Super.PostBeginPlay();
}

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skking_blackMesh'
}
