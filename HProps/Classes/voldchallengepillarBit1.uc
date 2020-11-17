//===============================================================================
//  [voldchallengepillarBit1] 
//===============================================================================

class voldchallengepillarBit1 extends HProps;
#exec MESH  MODELIMPORT MESH=voldchallengepillarBit1Mesh MODELFILE=models\voldchallengepillarBit1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldchallengepillarBit1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldchallengepillarBit1Anims ANIMFILE=models\voldchallengepillarBit1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldchallengepillarBit1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldchallengepillarBit1Mesh ANIM=voldchallengepillarBit1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldchallengepillarBit1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldchallengepillarBit1Tex0  FILE=TEXTURES\voldchallengepillarBit1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldchallengepillarBit1Mesh NUM=0 TEXTURE=voldchallengepillarBit1Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: volpilar_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\pillar

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldchallengepillarBit1Mesh'
}
