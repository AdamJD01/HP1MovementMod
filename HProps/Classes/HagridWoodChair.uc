//===============================================================================
//  [HagridWoodChair] 
//===============================================================================

class HagridWoodChair extends HProps;
#exec MESH  MODELIMPORT MESH=HagridWoodChairMesh MODELFILE=models\HagridWoodChairMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridWoodChairMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridWoodChairAnims ANIMFILE=models\HagridWoodChairAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridWoodChairMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridWoodChairMesh ANIM=HagridWoodChairAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridWoodChairAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridWoodChairTex0  FILE=TEXTURES\HagridWoodChairTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=HagridWoodChairTex1  FILE=TEXTURES\HagridWoodChairTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridWoodChairMesh NUM=0 TEXTURE=HagridWoodChairTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=HagridWoodChairMesh NUM=1 TEXTURE=HagridWoodChairTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: hagchar2_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Table Chairs 
// Original material [1] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: hagchar2_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\Table Chairs

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridWoodChairMesh'
}
