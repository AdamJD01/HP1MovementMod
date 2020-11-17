//===============================================================================
//  [FlipendoVaseMing] 
//===============================================================================

class FlipendoVaseMing extends FlipendoVaseBronze;
#exec MESH  MODELIMPORT MESH=FlipendoVaseMingMesh MODELFILE=models\FlipendoVaseMingMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseMingMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseMingAnims ANIMFILE=models\FlipendoVaseMingAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseMingMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseMingMesh ANIM=FlipendoVaseMingAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseMingAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseMingTex0  FILE=TEXTURES\FlipendoVaseMingTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseMingMesh NUM=0 TEXTURE=FlipendoVaseMingTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: fvseming_128.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\Flipendo Vases

defaultproperties
{
     brokentype=Class'HProps.FlipendoVaseMingBroken'
     Mesh=SkeletalMesh'HProps.FlipendoVaseMingMesh'
}
