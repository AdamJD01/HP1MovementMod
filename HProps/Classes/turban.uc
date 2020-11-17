//===============================================================================
//  [turban] 
//===============================================================================

class turban extends HProps;
#exec MESH  MODELIMPORT MESH=turbanMesh MODELFILE=models\turbanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=turbanMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=turbanAnims ANIMFILE=models\turbanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=turbanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=turbanMesh ANIM=turbanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=turbanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=turbanTex0  FILE=TEXTURES\turbanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=turbanMesh NUM=0 TEXTURE=turbanTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: QUIR_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Quirrel

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.turbanMesh'
}
