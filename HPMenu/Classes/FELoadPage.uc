class FELoadPage expands FEFilePage;

function SelectFile (int i)
{
	HPConsole(root.console).bInHubFlow = true;	// We're returning to the normal hub-to-hub game flow
	GetLevel().ConsoleCommand("open save" $i $".usa");

// not needed anymore	FEBook(book).ShowTabs(true);	//show book tabs now that game has started
	FEBook(book).bGamePlaying=true;

	FEBook(book).CloseBook();

}

function CreateFileDetails (int i)
{
}

function ShowFileDetails (int i)
{
	if (info == None)
		SaveFileDetails[i].SelectBtn.bDisabled = true;
	else
		SaveFileDetails[i].SelectBtn.bDisabled = false;
}

defaultproperties
{
}
