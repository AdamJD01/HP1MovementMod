//===============================================================================
//  [TrollThrowStone] 
//===============================================================================

class TrollThrowStone extends BaseToiletObject;
#exec MESH  MODELIMPORT MESH=TrollThrowStoneMesh MODELFILE=models\TrollThrowStoneMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowStoneMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowStoneAnims ANIMFILE=models\TrollThrowStoneAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowStoneMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowStoneMesh ANIM=TrollThrowStoneAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowStoneAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowStoneTex0  FILE=TEXTURES\TrollThrowStoneTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowStoneMesh NUM=0 TEXTURE=TrollThrowStoneTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: TrolBlck_128.bmp  Path: D:\Harry Potter\Art\Objects\Troll Throwing Objects\Stone Block 

function explode(vector HitNormal)
{
	local HProps	Fragment;

	ExplosionFX = spawn(class'ChessExplo', [spawnlocation] location);

	Velocity *= 0.5;

	Fragment = spawn(class'TrollThrowStoneShard', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));
	
	Fragment = spawn(class'TrollThrowStoneShard', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	Fragment = spawn(class'TrollThrowStoneShard', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	Fragment = spawn(class'TrollThrowStoneShard', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));
	
	Fragment = spawn(class'TrollThrowStoneShard', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	Fragment = spawn(class'TrollThrowStoneShard', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	destroy();
}

defaultproperties
{
     Mesh=SkeletalMesh'HProps.TrollThrowStoneMesh'
}
