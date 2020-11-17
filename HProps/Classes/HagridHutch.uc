//===============================================================================
//  [HagridHutch] 
//===============================================================================

class HagridHutch extends HProps;
#exec MESH  MODELIMPORT MESH=HagridHutchMesh MODELFILE=models\HagridHutchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridHutchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridHutchAnims ANIMFILE=models\HagridHutchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridHutchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridHutchMesh ANIM=HagridHutchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridHutchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridHutchTex0  FILE=TEXTURES\HagridHutchTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=HagridHutchTex1  FILE=TEXTURES\HagridHutchTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridHutchMesh NUM=0 TEXTURE=HagridHutchTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=HagridHutchMesh NUM=1 TEXTURE=HagridHutchTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: haghutch_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\hutch 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: haghutch_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\hutch

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridHutchMesh'
}
