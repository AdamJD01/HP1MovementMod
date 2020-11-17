class FESavePage expands FEFilePage;

function SelectFile (int i)
{
	// Save Game
	//----------

	hpConsole (root.console).DoLevelSave (i);

	ShowWindowFile (i);
}

function CreateFileDetails (int xx)
{
}

function ShowFileDetails (int xx)
{
	if (SaveFileDetails [xx].SelectBtn.Text == "")
		SaveFileDetails [xx].SelectBtn.setText("Save Game");
}

defaultproperties
{
}
