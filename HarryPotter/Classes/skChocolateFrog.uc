//===============================================================================
//  [skChocolateFrog] 
//===============================================================================

class skChocolateFrog extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skChocolateFrogMesh MODELFILE=models\skChocolateFrog.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skChocolateFrogMesh X=0 Y=0 Z=40 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skChocolateFrogAnims ANIMFILE=models\skChocolateFrog.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skChocolateFrogMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skChocolateFrogMesh ANIM=skChocolateFrogAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skChocolateFrogAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skChocolateFrogTex0  FILE=TEXTURES\chocfrog.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skChocolateFrogMesh NUM=0 TEXTURE=skChocolateFrogTex0

// Original material [0] is [CHOCFROG_SKIN00] SkinIndex: 0 Bitmap: chocfrog.bmp  Path: C:\~Work\Harry Potter\Characters\Chocolate Frog

defaultproperties
{
}
