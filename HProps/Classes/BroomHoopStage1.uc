//=============================================================================
// BroomHoopStage1 -- A hoop for broom training stage 1
//=============================================================================
class BroomHoopStage1 extends BroomHoop;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	// Load hoop skin texture and declare which stage it's for
	Skin = Texture( DynamicLoadObject("HP_BroomTraining.TrainingHoop.BTStage1", class'FireTexture') );
	Stage=1;
}

defaultproperties
{
     Stage=1
     PlayScale=1.333
     attachedParticleClass=Class'HPParticle.Ring1'
     Group=Stage1
     CollisionRadius=90
     CollisionHeight=90
}
