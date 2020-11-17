//===============================================================================
//  [GryfCoatRack] 
//===============================================================================

class GryfCoatRack extends HProps;
#exec MESH  MODELIMPORT MESH=GryfCoatRackMesh MODELFILE=models\GryfCoatRackMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfCoatRackMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfCoatRackAnims ANIMFILE=models\GryfCoatRackAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfCoatRackMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfCoatRackMesh ANIM=GryfCoatRackAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfCoatRackAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfCoatRackTex0  FILE=TEXTURES\GryfCoatRackTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfCoatRackMesh NUM=0 TEXTURE=GryfCoatRackTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: coatrack_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfCoatRackMesh'
}
