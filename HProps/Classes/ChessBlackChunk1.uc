//===============================================================================
//  [ChessBlackChunk1] 
//===============================================================================

class ChessBlackChunk1 extends HProps;
#exec MESH  MODELIMPORT MESH=ChessBlackChunk1Mesh MODELFILE=models\ChessBlackChunk1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChessBlackChunk1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChessBlackChunk1Anims ANIMFILE=models\ChessBlackChunk1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChessBlackChunk1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChessBlackChunk1Mesh ANIM=ChessBlackChunk1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChessBlackChunk1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChessBlackChunk1Tex0  FILE=TEXTURES\ChessBlackChunk1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChessBlackChunk1Mesh NUM=0 TEXTURE=ChessBlackChunk1Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: blackchunks_128.bmp  Path: D:\Harry Potter\Art\Characters\Chess_Pieces

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChessBlackChunk1Mesh'
}
