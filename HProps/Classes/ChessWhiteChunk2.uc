//===============================================================================
//  [ChessWhiteChunk2] 
//===============================================================================

class ChessWhiteChunk2 extends HProps;
#exec MESH  MODELIMPORT MESH=ChessWhiteChunk2Mesh MODELFILE=models\ChessWhiteChunk2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChessWhiteChunk2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChessWhiteChunk2Anims ANIMFILE=models\ChessWhiteChunk2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChessWhiteChunk2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChessWhiteChunk2Mesh ANIM=ChessWhiteChunk2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChessWhiteChunk2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChessWhiteChunk2Tex0  FILE=TEXTURES\ChessWhiteChunk2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChessWhiteChunk2Mesh NUM=0 TEXTURE=ChessWhiteChunk2Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: whitechunks_128.bmp  Path: D:\Harry Potter\Art\Characters\Chess_Pieces

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChessWhiteChunk2Mesh'
}
