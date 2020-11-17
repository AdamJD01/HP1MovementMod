//===============================================================================
//  [PeeveThrowPot] 
//===============================================================================

class PeeveThrowPot extends HProps;
#exec MESH  MODELIMPORT MESH=PeeveThrowPotMesh MODELFILE=models\PeeveThrowPotMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PeeveThrowPotMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PeeveThrowPotAnims ANIMFILE=models\PeeveThrowPotAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PeeveThrowPotMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PeeveThrowPotMesh ANIM=PeeveThrowPotAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PeeveThrowPotAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PeeveThrowPotTex0  FILE=TEXTURES\PeeveThrowPotTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PeeveThrowPotMesh NUM=0 TEXTURE=PeeveThrowPotTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: peevepot_128.bmp  Path: D:\Harry Potter\Art\Objects\Peeves Throwing Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PeeveThrowPotMesh'
}
