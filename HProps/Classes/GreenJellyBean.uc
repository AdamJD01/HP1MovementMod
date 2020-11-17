//===============================================================================
//  [GreenJellyBean] 
//===============================================================================

class GreenJellyBean extends jellybean;
#exec MESH  MODELIMPORT MESH=GreenJellyBeanMesh MODELFILE=models\GreenJellyBeanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenJellyBeanMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenJellyBeanAnims ANIMFILE=models\GreenJellyBeanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenJellyBeanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenJellyBeanMesh ANIM=GreenJellyBeanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenJellyBeanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenJellyBeanTex0  FILE=TEXTURES\GreenJellyBeanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenJellyBeanMesh NUM=0 TEXTURE=GreenJellyBeanTex0

// Original material [0] is [Material #25] SkinIndex: 0 Bitmap: grenbean_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     Mesh=SkeletalMesh'HProps.GreenJellyBeanMesh'
}
