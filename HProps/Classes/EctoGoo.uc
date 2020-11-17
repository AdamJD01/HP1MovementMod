//===============================================================================
//  [EctoGoo] 
//===============================================================================

class EctoGoo extends HProps;
#exec MESH  MODELIMPORT MESH=EctoGooMesh MODELFILE=models\EctoGooMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=EctoGooMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=EctoGooAnims ANIMFILE=models\EctoGooAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=EctoGooMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=EctoGooMesh ANIM=EctoGooAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=EctoGooAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=EctoGooTex0  FILE=TEXTURES\EctoGooTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=EctoGooMesh NUM=0 TEXTURE=EctoGooTex0

// Original material [0] is [Material #27] SkinIndex: 0 Bitmap: ectopgoo_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.EctoGooMesh'
}
