//===============================================================================
//  [GryfArmoire] 
//===============================================================================

class GryfArmoire extends HProps;
#exec MESH  MODELIMPORT MESH=GryfArmoireMesh MODELFILE=models\GryfArmoireMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfArmoireMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfArmoireAnims ANIMFILE=models\GryfArmoireAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfArmoireMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfArmoireMesh ANIM=GryfArmoireAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfArmoireAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfArmoireTex0  FILE=TEXTURES\GryfArmoireTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfArmoireMesh NUM=0 TEXTURE=GryfArmoireTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: garmoire_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfArmoireMesh'
}
