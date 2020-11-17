//===============================================================================
//  [skknight] 
//===============================================================================

class skknight extends HProps;
#exec MESH  MODELIMPORT MESH=skknightMesh MODELFILE=models\skknightMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skknightMesh X=0 Y=0 Z=47.5 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skknightAnims ANIMFILE=models\skknightAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skknightMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skknightMesh ANIM=skknightAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skknightAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skknightTex0  FILE=TEXTURES\skknightTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skknightMesh NUM=0 TEXTURE=skknightTex0

// Original material [0] is [Material #8] SkinIndex: 0 Bitmap: knight.bmp  Path: C:\~Work\Harry Potter\Characters\Suit of Armour

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.skknightMesh'
}
