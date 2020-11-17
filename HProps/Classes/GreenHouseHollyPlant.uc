//===============================================================================
//  [GreenHouseHollyPlant] 
//===============================================================================

class GreenHouseHollyPlant extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseHollyPlantMesh MODELFILE=models\GreenHouseHollyPlantMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseHollyPlantMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseHollyPlantAnims ANIMFILE=models\GreenHouseHollyPlantAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseHollyPlantMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseHollyPlantMesh ANIM=GreenHouseHollyPlantAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseHollyPlantAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseHollyPlantTex0  FILE=TEXTURES\GreenHouseHollyPlantTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseHollyPlantMesh NUM=0 TEXTURE=GreenHouseHollyPlantTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: grhplant_128.bmp  Path: D:\Harry Potter\Art\Objects\Greenhouse\plant_n_leaf

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseHollyPlantMesh'
}
