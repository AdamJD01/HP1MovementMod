//===============================================================================
//  [RedBlackStripeBean] 
//===============================================================================

class RedBlackStripeBean extends jellybean;
#exec MESH  MODELIMPORT MESH=RedBlackStripeBeanMesh MODELFILE=models\RedBlackStripeBeanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=RedBlackStripeBeanMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=RedBlackStripeBeanAnims ANIMFILE=models\RedBlackStripeBeanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=RedBlackStripeBeanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=RedBlackStripeBeanMesh ANIM=RedBlackStripeBeanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=RedBlackStripeBeanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=RedBlackStripeBeanTex0  FILE=TEXTURES\RedBlackStripeBeanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=RedBlackStripeBeanMesh NUM=0 TEXTURE=RedBlackStripeBeanTex0

// Original material [0] is [Material #25] SkinIndex: 0 Bitmap: stripebn_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects\Candy

defaultproperties
{
     Mesh=SkeletalMesh'HProps.RedBlackStripeBeanMesh'
}
