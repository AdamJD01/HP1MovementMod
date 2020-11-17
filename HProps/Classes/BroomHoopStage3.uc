//=============================================================================
// BroomHoopStage3 -- A hoop for broom training stage 3
//=============================================================================
class BroomHoopStage3 extends BroomHoop;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	// Load hoop skin texture and declare which stage it's for
	Skin = Texture( DynamicLoadObject("HP_BroomTraining.TrainingHoop.BTStage3", class'FireTexture') );
	Stage=3;
}

defaultproperties
{
     Stage=3
     attachedParticleClass=Class'HPParticle.Ring3'
     Group=Stage3
}
