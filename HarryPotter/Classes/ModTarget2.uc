//===============================================================================
//  [ModTarget2] 
//===============================================================================

class ModTarget2 extends Actor;
//#EXEC MESH  MODELIMPORT MESH=ModTarget2Mesh MODELFILE=models\ModTarget2.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=ModTarget2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=ModTarget2Anims ANIMFILE=models\ModTarget2.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=ModTarget2Mesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=ModTarget2Mesh ANIM=ModTarget2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=ModTarget2Anims VERBOSE

//#EXEC TEXTURE IMPORT NAME=ModTarget2Tex0  FILE=TEXTURES\Target1.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=ModTarget2Mesh NUM=0 TEXTURE=ModTarget2Tex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: Target1.bmp  Path: \\Baker\HPotterPC\Art\Texture maps\Kerwin Textures\FX

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.ModTarget2Mesh'
}
