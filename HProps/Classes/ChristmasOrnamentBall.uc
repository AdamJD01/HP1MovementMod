//===============================================================================
//  [ChristmasOrnamentBall] 
//===============================================================================

class ChristmasOrnamentBall extends HProps;
#exec MESH  MODELIMPORT MESH=ChristmasOrnamentBallMesh MODELFILE=models\ChristmasOrnamentBallMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChristmasOrnamentBallMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChristmasOrnamentBallAnims ANIMFILE=models\ChristmasOrnamentBallAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChristmasOrnamentBallMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChristmasOrnamentBallMesh ANIM=ChristmasOrnamentBallAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChristmasOrnamentBallAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChristmasOrnamentBallTex0  FILE=TEXTURES\ChristmasOrnamentBallTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChristmasOrnamentBallMesh NUM=0 TEXTURE=ChristmasOrnamentBallTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: xmasball_64.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Christmas ornaments

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChristmasOrnamentBallMesh'
}
