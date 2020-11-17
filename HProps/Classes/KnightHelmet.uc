//===============================================================================
//  [KnightHelmet] 
//===============================================================================

class KnightHelmet extends HProps;
#exec MESH  MODELIMPORT MESH=KnightHelmetMesh MODELFILE=models\KnightHelmetMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=KnightHelmetMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=KnightHelmetAnims ANIMFILE=models\KnightHelmetAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=KnightHelmetMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=KnightHelmetMesh ANIM=KnightHelmetAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=KnightHelmetAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=KnightHelmetTex0  FILE=TEXTURES\KnightHelmetTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=KnightHelmetMesh NUM=0 TEXTURE=KnightHelmetTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: hwhelmet_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.KnightHelmetMesh'
}
