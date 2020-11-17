//===============================================================================
//  [ChessWhiteChunk3] 
//===============================================================================

class ChessWhiteChunk3 extends HProps;
#exec MESH  MODELIMPORT MESH=ChessWhiteChunk3Mesh MODELFILE=models\ChessWhiteChunk3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChessWhiteChunk3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChessWhiteChunk3Anims ANIMFILE=models\ChessWhiteChunk3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChessWhiteChunk3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChessWhiteChunk3Mesh ANIM=ChessWhiteChunk3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChessWhiteChunk3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChessWhiteChunk3Tex0  FILE=TEXTURES\ChessWhiteChunk3Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChessWhiteChunk3Mesh NUM=0 TEXTURE=ChessWhiteChunk3Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: whitechunks_128.bmp  Path: D:\Harry Potter\Art\Characters\Chess_Pieces

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChessWhiteChunk3Mesh'
}
