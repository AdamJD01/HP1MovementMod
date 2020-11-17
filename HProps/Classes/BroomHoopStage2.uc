//=============================================================================
// BroomHoopStage2 -- A hoop for broom training stage 2
//=============================================================================
class BroomHoopStage2 extends BroomHoop;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	// Load hoop skin texture and declare which stage it's for
	Skin = Texture( DynamicLoadObject("HP_BroomTraining.TrainingHoop.BTStage2", class'FireTexture') );
	Stage=2;
}

defaultproperties
{
     Stage=2
     attachedParticleClass=Class'HPParticle.Ring2'
     Group=Stage2
}
