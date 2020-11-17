//===============================================================================
//  [PaintCans] 
//===============================================================================

class PaintCans extends DProps;
#exec MESH  MODELIMPORT MESH=PaintCansMesh MODELFILE=models\PaintCans.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PaintCansMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PaintCansAnims ANIMFILE=models\PaintCans.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PaintCansMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PaintCansMesh ANIM=PaintCansAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PaintCansAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PaintCansTex0  FILE=TEXTURES\PaintCansTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PaintCansMesh NUM=0 TEXTURE=PaintCansTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: paintcan_128.bmp  Path: H:\Art\Models\Objects\Dursley Props

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'DProps.PaintCansMesh'
}
