//===============================================================================
//  [GreenPurpleCheckerBean] 
//===============================================================================

class GreenPurpleCheckerBean extends jellybean;
#exec MESH  MODELIMPORT MESH=GreenPurpleCheckerBeanMesh MODELFILE=models\GreenPurpleCheckerBeanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenPurpleCheckerBeanMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenPurpleCheckerBeanAnims ANIMFILE=models\GreenPurpleCheckerBeanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenPurpleCheckerBeanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenPurpleCheckerBeanMesh ANIM=GreenPurpleCheckerBeanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenPurpleCheckerBeanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenPurpleCheckerBeanTex0  FILE=TEXTURES\GreenPurpleCheckerBeanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenPurpleCheckerBeanMesh NUM=0 TEXTURE=GreenPurpleCheckerBeanTex0

// Original material [0] is [Material #25] SkinIndex: 0 Bitmap: chckbean_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects\Candy

defaultproperties
{
     Mesh=SkeletalMesh'HProps.GreenPurpleCheckerBeanMesh'
}
