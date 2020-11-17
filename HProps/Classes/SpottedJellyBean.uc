//===============================================================================
//  [SpottedJellyBean] 
//===============================================================================

class SpottedJellyBean extends jellybean;
#exec MESH  MODELIMPORT MESH=SpottedJellyBeanMesh MODELFILE=models\SpottedJellyBeanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SpottedJellyBeanMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SpottedJellyBeanAnims ANIMFILE=models\SpottedJellyBeanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SpottedJellyBeanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SpottedJellyBeanMesh ANIM=SpottedJellyBeanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SpottedJellyBeanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SpottedJellyBeanTex0  FILE=TEXTURES\SpottedJellyBeanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SpottedJellyBeanMesh NUM=0 TEXTURE=SpottedJellyBeanTex0

// Original material [0] is [Material #25] SkinIndex: 0 Bitmap: spotbean_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     Mesh=SkeletalMesh'HProps.SpottedJellyBeanMesh'
}
