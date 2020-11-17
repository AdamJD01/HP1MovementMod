//===============================================================================
//  [Bush02] 
//===============================================================================

class Bush02 extends HProps;
#exec MESH  MODELIMPORT MESH=Bush02Mesh MODELFILE=models\Bush02Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=Bush02Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=Bush02Anims ANIMFILE=models\Bush02Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=Bush02Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=Bush02Mesh ANIM=Bush02Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=Bush02Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=Bush02Tex0  FILE=TEXTURES\Bush02Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=Bush02Mesh NUM=0 TEXTURE=Bush02Tex0

// Original material [0] is [heather_skin00.MASKED] SkinIndex: 0 Bitmap: Heather.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.Bush02Mesh'
}
