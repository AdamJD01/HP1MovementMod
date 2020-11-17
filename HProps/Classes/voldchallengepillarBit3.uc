//===============================================================================
//  [voldchallengepillarBit3] 
//===============================================================================

class voldchallengepillarBit3 extends HProps;
#exec MESH  MODELIMPORT MESH=voldchallengepillarBit3Mesh MODELFILE=models\voldchallengepillarBit3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=voldchallengepillarBit3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=voldchallengepillarBit3Anims ANIMFILE=models\voldchallengepillarBit3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=voldchallengepillarBit3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=voldchallengepillarBit3Mesh ANIM=voldchallengepillarBit3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=voldchallengepillarBit3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=voldchallengepillarBit3Tex0  FILE=TEXTURES\voldchallengepillarBit3Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=voldchallengepillarBit3Mesh NUM=0 TEXTURE=voldchallengepillarBit3Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: volpilar_256.bmp  Path: D:\Harry Potter\Art\Objects\Voldemort Challenge\pillar

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldchallengepillarBit3Mesh'
}
