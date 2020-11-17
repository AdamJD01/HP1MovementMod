//===============================================================================
//  [skgoat] 
//===============================================================================

class skgoat extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skgoatMesh MODELFILE=models\skgoatMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skgoatMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skgoatAnims ANIMFILE=models\skgoatAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skgoatMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skgoatMesh ANIM=skgoatAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skgoatAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skgoatTex0  FILE=TEXTURES\skgoatTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skgoatMesh NUM=0 TEXTURE=skgoatTex0

// Original material [0] is [GOAT_SKIN00] SkinIndex: 0 Bitmap: GOAT_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Goat

defaultproperties
{
}
