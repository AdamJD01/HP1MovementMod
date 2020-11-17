//===============================================================================
//  [GreenHousePlant2] 
//===============================================================================

class GreenHousePlant2 extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHousePlant2Mesh MODELFILE=models\GreenHousePlant2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHousePlant2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHousePlant2Anims ANIMFILE=models\GreenHousePlant2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHousePlant2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHousePlant2Mesh ANIM=GreenHousePlant2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHousePlant2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHousePlant2Tex0  FILE=TEXTURES\GreenHousePlant2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHousePlant2Mesh NUM=0 TEXTURE=GreenHousePlant2Tex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: GreenHousePlant02.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHousePlant2Mesh'
}
