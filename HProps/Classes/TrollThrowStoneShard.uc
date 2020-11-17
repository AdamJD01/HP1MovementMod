//===============================================================================
//  [TrollThrowStoneShard] 
//===============================================================================

class TrollThrowStoneShard extends TrollThrowbaseFragment;
#exec MESH  MODELIMPORT MESH=TrollThrowStoneShardMesh MODELFILE=models\TrollThrowStoneShardMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowStoneShardMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowStoneShardAnims ANIMFILE=models\TrollThrowStoneShardAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowStoneShardMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowStoneShardMesh ANIM=TrollThrowStoneShardAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowStoneShardAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowStoneShardTex0  FILE=TEXTURES\TrollThrowStoneShardTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowStoneShardMesh NUM=0 TEXTURE=TrollThrowStoneShardTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: TrolBlck_128.bmp  Path: D:\Harry Potter\Art\Objects\Troll Throwing Objects\Stone Block

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollThrowStoneShardMesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
