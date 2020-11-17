//===============================================================================
//  [voldchallengepillarBit4] 
//===============================================================================

class voldchallengepillarBit4 extends HProps;
#exec MESH  MODELIMPORT MESH=voldchallengepillarBit4Mesh MODELFILE=models\voldchallengepillarBit4Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldchallengepillarBit4Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldchallengepillarBit4Anims ANIMFILE=models\voldchallengepillarBit4Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldchallengepillarBit4Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldchallengepillarBit4Mesh ANIM=voldchallengepillarBit4Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldchallengepillarBit4Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldchallengepillarBit4Tex0  FILE=TEXTURES\voldchallengepillarBit4Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldchallengepillarBit4Mesh NUM=0 TEXTURE=voldchallengepillarBit4Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: volpilar_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\pillar

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldchallengepillarBit4Mesh'
}
