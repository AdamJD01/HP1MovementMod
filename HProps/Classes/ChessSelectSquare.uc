//===============================================================================
//  [ChessSelectSquare] 
//===============================================================================

class ChessSelectSquare extends HProps;
#exec MESH  MODELIMPORT MESH=ChessSelectSquareMesh MODELFILE=models\ChessSelectSquareMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChessSelectSquareMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChessSelectSquareAnims ANIMFILE=models\ChessSelectSquareAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChessSelectSquareMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChessSelectSquareMesh ANIM=ChessSelectSquareAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChessSelectSquareAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChessSelectSquareTex0  FILE=TEXTURES\ChessSelectSquareTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChessSelectSquareMesh NUM=0 TEXTURE=ChessSelectSquareTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: chsquare_64.bmp  Path: D:\Harry Potter\Art\Objects\Chess Selector

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChessSelectSquareMesh'
}
