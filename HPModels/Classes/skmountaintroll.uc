//===============================================================================
//  [skmountaintroll] 
//===============================================================================

class skmountaintroll extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skmountaintrollMesh MODELFILE=models\skmountaintrollMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skmountaintrollMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skmountaintrollAnims ANIMFILE=models\skmountaintrollAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skmountaintrollMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skmountaintrollMesh ANIM=skmountaintrollAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skmountaintrollAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skmountaintrollTex0  FILE=TEXTURES\skmountaintrollTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skmountaintrollTex1  FILE=TEXTURES\skmountaintrollTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skmountaintrollTex2  FILE=TEXTURES\skmountaintrollTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skmountaintrollMesh NUM=0 TEXTURE=skmountaintrollTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skmountaintrollMesh NUM=1 TEXTURE=skmountaintrollTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skmountaintrollMesh NUM=2 TEXTURE=skmountaintrollTex2

#exec ANIM NOTIFY ANIM=skmountaintrollAnims SEQ=Walk TIME=0.3 FUNCTION=playfootstep
#exec ANIM NOTIFY ANIM=skmountaintrollAnims SEQ=Walk TIME=0.789 FUNCTION=playfootstep
#exec ANIM NOTIFY ANIM=skmountaintrollAnims SEQ=Run TIME=0.3 FUNCTION=playfootstep
#exec ANIM NOTIFY ANIM=skmountaintrollAnims SEQ=Run TIME=0.789 FUNCTION=playfootstep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: MTroll_SKIN00.bmp  Path: H:\Art\Design\Creatures\Mountain Troll 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: MTroll_SKIN01.bmp  Path: H:\Art\Design\Creatures\Mountain Troll 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: MTroll_SKIN02.bmp  Path: H:\Art\Design\Creatures\Mountain Troll

defaultproperties
{
}
