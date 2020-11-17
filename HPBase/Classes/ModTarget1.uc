//===============================================================================
//  [ModTarget1] 
//===============================================================================

class ModTarget1 extends Actor;
#exec MESH  MODELIMPORT MESH=ModTarget1Mesh MODELFILE=models\ModTarget1.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ModTarget1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ModTarget1Anims ANIMFILE=models\ModTarget1.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ModTarget1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ModTarget1Mesh ANIM=ModTarget1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ModTarget1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=ModTarget1Tex0  FILE=TEXTURES\ModTarget1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ModTarget1Mesh NUM=0 TEXTURE=ModTarget1Tex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: Target1.bmp  Path: \\Baker\HPotterPC\Art\Texture maps\Kerwin Textures\FX

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPBase.ModTarget1Mesh'
}
