//===============================================================================
//  [TrollThrowFrag1] 
//===============================================================================

class TrollThrowFrag1 extends TrollThrowbaseFragment;

#exec MESH  MODELIMPORT MESH=TrollThrowFrag1Mesh MODELFILE=models\TrollThrowFrag1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowFrag1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowFrag1Anims ANIMFILE=models\TrollThrowFrag1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowFrag1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowFrag1Mesh ANIM=TrollThrowFrag1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowFrag1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowFrag1Tex0  FILE=TEXTURES\TrollThrowFrag1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowFrag1Mesh NUM=0 TEXTURE=TrollThrowFrag1Tex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: TrollThrowToilet.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollThrowFrag1Mesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
