//===============================================================================
//  [HagridTeaPot] 
//===============================================================================

class HagridTeaPot extends HProps;
#exec MESH  MODELIMPORT MESH=HagridTeaPotMesh MODELFILE=models\HagridTeaPotMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridTeaPotMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridTeaPotAnims ANIMFILE=models\HagridTeaPotAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridTeaPotMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridTeaPotMesh ANIM=HagridTeaPotAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridTeaPotAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridTeaPotTex0  FILE=TEXTURES\HagridTeaPotTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=HagridTeaPotTex1  FILE=TEXTURES\HagridTeaPotTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridTeaPotMesh NUM=0 TEXTURE=HagridTeaPotTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=HagridTeaPotMesh NUM=1 TEXTURE=HagridTeaPotTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: hgteapot_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Teaset 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: hgteapot_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Teaset

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridTeaPotMesh'
}
