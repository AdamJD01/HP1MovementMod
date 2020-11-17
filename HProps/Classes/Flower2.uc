//===============================================================================
//  [Flower2] 
//===============================================================================

class Flower2 extends HProps;
#exec MESH  MODELIMPORT MESH=Flower2Mesh MODELFILE=models\Flower2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=Flower2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=Flower2Anims ANIMFILE=models\Flower2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=Flower2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=Flower2Mesh ANIM=Flower2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=Flower2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=Flower2Tex0  FILE=TEXTURES\Flower2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=Flower2Mesh NUM=0 TEXTURE=Flower2Tex0

// Original material [0] is [skin00.MASKED] SkinIndex: 0 Bitmap: Flower2.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.Flower2Mesh'
}
