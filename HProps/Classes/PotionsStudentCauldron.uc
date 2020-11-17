//===============================================================================
//  [PotionsStudentCauldron] 
//===============================================================================

class PotionsStudentCauldron extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsStudentCauldronMesh MODELFILE=models\PotionsStudentCauldronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsStudentCauldronMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsStudentCauldronAnims ANIMFILE=models\PotionsStudentCauldronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsStudentCauldronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsStudentCauldronMesh ANIM=PotionsStudentCauldronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsStudentCauldronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsStudentCauldronTex0  FILE=TEXTURES\PotionsStudentCauldronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsStudentCauldronMesh NUM=0 TEXTURE=PotionsStudentCauldronTex0

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsStudentCauldronMesh'
}
