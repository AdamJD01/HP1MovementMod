//===============================================================================
//  [HogwartsVase] 
//===============================================================================

class HogwartsVase extends HProps;
#exec MESH  MODELIMPORT MESH=HogwartsVaseMesh MODELFILE=models\HogwartsVaseMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogwartsVaseMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogwartsVaseAnims ANIMFILE=models\HogwartsVaseAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogwartsVaseMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogwartsVaseMesh ANIM=HogwartsVaseAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogwartsVaseAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogwartsVaseTex0  FILE=TEXTURES\HogwartsVaseTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogwartsVaseMesh NUM=0 TEXTURE=HogwartsVaseTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: hogvase_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogwartsVaseMesh'
}
