//===============================================================================
//  [ChessBlackChunk2] 
//===============================================================================

class ChessBlackChunk2 extends HProps;
#exec MESH  MODELIMPORT MESH=ChessBlackChunk2Mesh MODELFILE=models\ChessBlackChunk2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChessBlackChunk2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChessBlackChunk2Anims ANIMFILE=models\ChessBlackChunk2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChessBlackChunk2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChessBlackChunk2Mesh ANIM=ChessBlackChunk2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChessBlackChunk2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChessBlackChunk2Tex0  FILE=TEXTURES\ChessBlackChunk2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChessBlackChunk2Mesh NUM=0 TEXTURE=ChessBlackChunk2Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: blackchunks_128.bmp  Path: D:\Harry Potter\Art\Characters\Chess_Pieces

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChessBlackChunk2Mesh'
}
