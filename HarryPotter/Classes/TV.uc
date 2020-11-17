//===============================================================================
//  [TV] 
//===============================================================================

class TV extends baseProps;
//#EXEC MESH  MODELIMPORT MESH=TVMesh MODELFILE=models\TV.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=TVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=TVAnims ANIMFILE=models\TV.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=TVMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=TVMesh ANIM=TVAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=TVAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=TVTex0  FILE=TEXTURES\televisn_128.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=TVTex1  FILE=TEXTURES\televisn_129.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=TVMesh NUM=0 TEXTURE=TVTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: televisn_128.bmp  Path: H:\Art\Models\Objects\Dursley Props\TV 


function turnOn()
{
	skin=texture'tvTex1';
//cmp	PlaySound(waterstep, SLOT_Interact, 2.2, false, 1000.0, 1.0);

}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.TVMesh'
}
