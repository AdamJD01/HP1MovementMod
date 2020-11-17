//===============================================================================
//  [PeeveThrowApple] 
//===============================================================================

class PeeveThrowApple extends HProps;
#exec MESH  MODELIMPORT MESH=PeeveThrowAppleMesh MODELFILE=models\PeeveThrowAppleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PeeveThrowAppleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PeeveThrowAppleAnims ANIMFILE=models\PeeveThrowAppleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PeeveThrowAppleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PeeveThrowAppleMesh ANIM=PeeveThrowAppleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PeeveThrowAppleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PeeveThrowAppleTex0  FILE=TEXTURES\PeeveThrowAppleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PeeveThrowAppleMesh NUM=0 TEXTURE=PeeveThrowAppleTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: pveapple_64.bmp  Path: D:\Harry Potter\Art\Objects\Peeves Throwing Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPBase.PeeveThrowAppleMesh'
}
