//===============================================================================
//  [sktrollnoclub] 
//===============================================================================

class sktrollnoclub extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=sktrollnoclubMesh MODELFILE=models\sktrollnoclubMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=sktrollnoclubMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=sktrollnoclubAnims ANIMFILE=models\sktrollnoclubAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=sktrollnoclubMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=sktrollnoclubMesh ANIM=sktrollnoclubAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=sktrollnoclubAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=sktrollnoclubTex0  FILE=TEXTURES\sktrollnoclubTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=sktrollnoclubTex1  FILE=TEXTURES\sktrollnoclubTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=sktrollnoclubMesh NUM=0 TEXTURE=sktrollnoclubTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=sktrollnoclubMesh NUM=1 TEXTURE=sktrollnoclubTex1

#exec MESH WEAPONATTACH MESH=sktrollnoclubMesh BONE="RightHand"
#exec MESH WEAPONPOSITION MESH=sktrollnoclubMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: MTroll_SKIN00.bmp  Path: H:\Art\Design\Creatures\Mountain Troll 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: MTroll_SKIN01.bmp  Path: H:\Art\Design\Creatures\Mountain Troll

defaultproperties
{
}
