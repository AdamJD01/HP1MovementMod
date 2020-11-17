//===============================================================================
//  [SmallWoodenBox] 
//===============================================================================

class SmallWoodenBox extends HProps;
#exec MESH  MODELIMPORT MESH=SmallWoodenBoxMesh MODELFILE=models\SmallWoodenBoxMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SmallWoodenBoxMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SmallWoodenBoxAnims ANIMFILE=models\SmallWoodenBoxAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SmallWoodenBoxMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SmallWoodenBoxMesh ANIM=SmallWoodenBoxAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SmallWoodenBoxAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SmallWoodenBoxTex0  FILE=TEXTURES\SmallWoodenBoxTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SmallWoodenBoxMesh NUM=0 TEXTURE=SmallWoodenBoxTex0

// Original material [0] is [Material #25] SkinIndex: 0 Bitmap: woodbox1_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.SmallWoodenBoxMesh'
}
