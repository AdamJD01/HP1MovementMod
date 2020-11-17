//===============================================================================
//  [GryfsmCauldron] 
//===============================================================================

class GryfsmCauldron extends HProps;
#exec MESH  MODELIMPORT MESH=GryfsmCauldronMesh MODELFILE=models\GryfsmCauldronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfsmCauldronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfsmCauldronAnims ANIMFILE=models\GryfsmCauldronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfsmCauldronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfsmCauldronMesh ANIM=GryfsmCauldronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfsmCauldronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfsmCauldronTex0  FILE=TEXTURES\GryfsmCauldronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfsmCauldronMesh NUM=0 TEXTURE=GryfsmCauldronTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: couldron_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfsmCauldronMesh'
}
