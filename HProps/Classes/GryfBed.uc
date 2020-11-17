//===============================================================================
//  [GryfBed] 
//===============================================================================

class GryfBed extends HProps;
#exec MESH  MODELIMPORT MESH=GryfBedMesh MODELFILE=models\GryfBedMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfBedMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfBedAnims ANIMFILE=models\GryfBedAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfBedMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfBedMesh ANIM=GryfBedAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfBedAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfBedTex0  FILE=TEXTURES\GryfBedTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfBedMesh NUM=0 TEXTURE=GryfBedTex0

// Original material [0] is [Material #3] SkinIndex: 0 Bitmap: gryffbed_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfBedMesh'
}
