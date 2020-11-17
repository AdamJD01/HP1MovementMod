//===============================================================================
//  [DevilSnarePlantBase] 
//===============================================================================

class DevilSnarePlantBase extends HProps;
#exec MESH  MODELIMPORT MESH=DevilSnarePlantBaseMesh MODELFILE=models\DevilSnarePlantBaseMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DevilSnarePlantBaseMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DevilSnarePlantBaseAnims ANIMFILE=models\DevilSnarePlantBaseAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DevilSnarePlantBaseMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DevilSnarePlantBaseMesh ANIM=DevilSnarePlantBaseAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DevilSnarePlantBaseAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DevilSnarePlantBaseTex0  FILE=TEXTURES\DevilSnarePlantBaseTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DevilSnarePlantBaseMesh NUM=0 TEXTURE=DevilSnarePlantBaseTex0

// Original material [0] is [DEVIL_SKIN00.MASKED] SkinIndex: 0 Bitmap: DEVILPLANT_SKIN03.bmp  Path: D:\Harry Potter\Art\Characters\Devil'sSnare

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DevilSnarePlantBaseMesh'
}
