//===============================================================================
//  [GreenhouseTree] 
//===============================================================================

class GreenhouseTree extends HProps;
#exec MESH  MODELIMPORT MESH=GreenhouseTreeMesh MODELFILE=models\GreenhouseTreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenhouseTreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenhouseTreeAnims ANIMFILE=models\GreenhouseTreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenhouseTreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenhouseTreeMesh ANIM=GreenhouseTreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenhouseTreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenhouseTreeTex0  FILE=TEXTURES\GreenhouseTreeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenhouseTreeMesh NUM=0 TEXTURE=GreenhouseTreeTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: knobbybark.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\tree

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenhouseTreeMesh'
}
