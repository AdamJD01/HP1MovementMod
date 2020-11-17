//===============================================================================
//  [Bush01] 
//===============================================================================

class Bush01 extends HProps;
#exec MESH  MODELIMPORT MESH=Bush01Mesh MODELFILE=models\Bush01Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=Bush01Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=Bush01Anims ANIMFILE=models\Bush01Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=Bush01Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=Bush01Mesh ANIM=Bush01Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=Bush01Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=Bush01Tex0  FILE=TEXTURES\Bush01Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=Bush01Tex1  FILE=TEXTURES\Bush01Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=Bush01Mesh NUM=0 TEXTURE=Bush01Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=Bush01Mesh NUM=1 TEXTURE=Bush01Tex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: BushCore01.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [heather_skin01.MASKED] SkinIndex: 1 Bitmap: BushSprite01.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.Bush01Mesh'
}
