//===============================================================================
//  [BlueJellyBean] 
//===============================================================================

class BlueJellyBean extends JellyBean;
#exec MESH  MODELIMPORT MESH=BlueJellyBeanMesh MODELFILE=models\BlueJellyBeanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BlueJellyBeanMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BlueJellyBeanAnims ANIMFILE=models\BlueJellyBeanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BlueJellyBeanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BlueJellyBeanMesh ANIM=BlueJellyBeanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BlueJellyBeanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BlueJellyBeanTex0  FILE=TEXTURES\BlueJellyBeanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BlueJellyBeanMesh NUM=0 TEXTURE=BlueJellyBeanTex0

// Original material [0] is [Material #25] SkinIndex: 0 Bitmap: bluebean_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     Mesh=SkeletalMesh'HProps.BlueJellyBeanMesh'
}
