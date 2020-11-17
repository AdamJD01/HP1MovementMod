//===============================================================================
//  [GreenHouseFaucet] 
//===============================================================================

class GreenHouseFaucet extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseFaucetMesh MODELFILE=models\GreenHouseFaucetMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseFaucetMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseFaucetAnims ANIMFILE=models\GreenHouseFaucetAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseFaucetMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseFaucetMesh ANIM=GreenHouseFaucetAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseFaucetAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseFaucetTex0  FILE=TEXTURES\GreenHouseFaucetTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseFaucetMesh NUM=0 TEXTURE=GreenHouseFaucetTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: grhfucet_128.bmp  Path: D:\Harry Potter\Art\Objects\Greenhouse\wheel spigot

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseFaucetMesh'
}
