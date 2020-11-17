//===============================================================================
//  [GreenhouseHPlant1] 
//===============================================================================

class GreenhouseHPlant1 extends HProps;
#exec MESH  MODELIMPORT MESH=GreenhouseHPlant1Mesh MODELFILE=models\GreenhouseHPlant1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenhouseHPlant1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenhouseHPlant1Anims ANIMFILE=models\GreenhouseHPlant1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenhouseHPlant1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenhouseHPlant1Mesh ANIM=GreenhouseHPlant1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenhouseHPlant1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenhouseHPlant1Tex0  FILE=TEXTURES\GreenhouseHPlant1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenhouseHPlant1Mesh NUM=0 TEXTURE=GreenhouseHPlant1Tex0

// Original material [0] is [SKIN01.MASKED] SkinIndex: 1 Bitmap: HangingPlant1.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenhouseHPlant1Mesh'
}
