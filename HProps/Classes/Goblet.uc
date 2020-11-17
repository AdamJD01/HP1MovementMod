//===============================================================================
//  [Goblet] 
//===============================================================================

class Goblet extends HProps;
#exec MESH  MODELIMPORT MESH=GobletMesh MODELFILE=models\GobletMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GobletMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GobletAnims ANIMFILE=models\GobletAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GobletMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GobletMesh ANIM=GobletAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GobletAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GobletTex0  FILE=TEXTURES\GobletTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GobletMesh NUM=0 TEXTURE=GobletTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: hoggoblet_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GobletMesh'
}
