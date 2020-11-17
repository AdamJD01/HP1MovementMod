//===============================================================================
//  [CrystalBall] 
//===============================================================================

class CrystalBall extends HProps;
#exec MESH  MODELIMPORT MESH=CrystalBallMesh MODELFILE=models\CrystalBallMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=CrystalBallMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=CrystalBallAnims ANIMFILE=models\CrystalBallAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=CrystalBallMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=CrystalBallMesh ANIM=CrystalBallAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=CrystalBallAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=CrystalBallTex0  FILE=TEXTURES\CrystalBallTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=CrystalBallMesh NUM=0 TEXTURE=CrystalBallTex0

// Original material [0] is [Material #27] SkinIndex: 0 Bitmap: crysball_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.CrystalBallMesh'
}
