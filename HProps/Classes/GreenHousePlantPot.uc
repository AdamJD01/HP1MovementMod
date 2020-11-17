//===============================================================================
//  [GreenHousePlantPot] 
//===============================================================================

class GreenHousePlantPot extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHousePlantPotMesh MODELFILE=models\GreenHousePlantPotMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHousePlantPotMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHousePlantPotAnims ANIMFILE=models\GreenHousePlantPotAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHousePlantPotMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHousePlantPotMesh ANIM=GreenHousePlantPotAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHousePlantPotAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHousePlantPotTex0  FILE=TEXTURES\GreenHousePlantPotTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHousePlantPotMesh NUM=0 TEXTURE=GreenHousePlantPotTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: emptypot_128.bmp  Path: D:\Harry Potter\Art\Objects\Greenhouse\Plant Pots

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHousePlantPotMesh'
}
