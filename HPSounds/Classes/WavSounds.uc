class WavSounds expands actor;



	//privhud.uc
#exec AUDIO IMPORT FILE="..\Sounds\Wavs\Scloak1.wav" NAME="letterSound" GROUP="SpellSounds"


	//mirrorTarget
#exec AUDIO IMPORT FILE="..\Sounds\S_spell_shrink.WAV" NAME="spellShrinkSound" GROUP="cast"
#exec AUDIO IMPORT FILE="..\Sounds\S_spell_shrink_unshrink.WAV" NAME="spellUnShrinkSound" GROUP="cast"

defaultproperties
{
}
