//===============================================================================
//  [FlipendoVaseGreen] 
//===============================================================================

class FlipendoVaseGreen extends FlipendoVaseBronze;
#exec MESH  MODELIMPORT MESH=FlipendoVaseGreenMesh MODELFILE=models\FlipendoVaseGreenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseGreenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseGreenAnims ANIMFILE=models\FlipendoVaseGreenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseGreenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseGreenMesh ANIM=FlipendoVaseGreenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseGreenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseGreenTex0  FILE=TEXTURES\FlipendoVaseGreenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseGreenMesh NUM=0 TEXTURE=FlipendoVaseGreenTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: fvasegrn_64.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo\Flipendo Vases

defaultproperties
{
     brokentype=Class'HProps.FlipendoVaseGreenBroken'
     Mesh=SkeletalMesh'HProps.FlipendoVaseGreenMesh'
}
