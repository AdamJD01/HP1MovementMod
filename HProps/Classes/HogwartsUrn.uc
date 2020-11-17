//===============================================================================
//  [HogwartsUrn] 
//===============================================================================

class HogwartsUrn extends HProps;
#exec MESH  MODELIMPORT MESH=HogwartsUrnMesh MODELFILE=models\HogwartsUrnMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogwartsUrnMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogwartsUrnAnims ANIMFILE=models\HogwartsUrnAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogwartsUrnMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogwartsUrnMesh ANIM=HogwartsUrnAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogwartsUrnAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogwartsUrnTex0  FILE=TEXTURES\HogwartsUrnTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogwartsUrnMesh NUM=0 TEXTURE=HogwartsUrnTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: HWvaseTW_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogwartsUrnMesh'
}
