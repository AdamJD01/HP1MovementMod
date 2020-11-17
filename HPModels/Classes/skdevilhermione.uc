//===============================================================================
//  [skdevilhermione] 
//===============================================================================

class skdevilhermione extends HPMeshActor;
#exec MESH  MODELIMPORT MESH=skdevilhermioneMesh MODELFILE=models\skdevilhermioneMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skdevilhermioneMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skdevilhermioneAnims ANIMFILE=models\skdevilhermioneAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skdevilhermioneMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skdevilhermioneMesh ANIM=skdevilhermioneAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skdevilhermioneAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skdevilhermioneTex0  FILE=TEXTURES\skdevilhermioneTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilhermioneTex1  FILE=TEXTURES\skdevilhermioneTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilhermioneTex2  FILE=TEXTURES\skdevilhermioneTex2.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilhermioneTex3  FILE=TEXTURES\skdevilhermioneTex3.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilhermioneTex4  FILE=TEXTURES\skdevilhermioneTex4.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilhermioneMesh NUM=0 TEXTURE=skdevilhermioneTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilhermioneMesh NUM=1 TEXTURE=skdevilhermioneTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilhermioneMesh NUM=2 TEXTURE=skdevilhermioneTex2
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilhermioneMesh NUM=3 TEXTURE=skdevilhermioneTex3
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilhermioneMesh NUM=4 TEXTURE=skdevilhermioneTex4

// Original material [0] is [HERMIONE_SKIN00] SkinIndex: 0 Bitmap: HERMIONE_SKIN00.bmp  Path: D:\Harry Potter\Art\Characters\Hermione Granger 
// Original material [1] is [HERMIONE_SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HERMIONE_SKIN01.bmp  Path: D:\Harry Potter\Art\Characters\Hermione Granger 
// Original material [2] is [HERMIONE_SKIN02.MASKED] SkinIndex: 2 Bitmap: HERMIONE_SKIN02.bmp  Path: D:\Harry Potter\Art\Characters\Hermione Granger 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: DEVILPLANT_SKIN00.bmp  Path: H:\Art\Design\Creatures\Devil's Snare 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: DEVILPLANT_SKIN01.bmp  Path: H:\Art\Design\Creatures\Devil's Snare

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdevilhermioneMesh'
}
