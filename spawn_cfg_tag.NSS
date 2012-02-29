//
// Spawn Groups
//
//
// nSpawnTag: Index used to override the created object's tag
//
//
string TagSpawn(object oSpawn)
{
    // Initialize
    string sRetTemplate = "";

    // Initialize Values
	int nSpawnTag = GetLocalInt(oSpawn, "f_SpawnTag");
	

	if (nSpawnTag > 0)
    {
//
// Only Make Modifications Between These Lines
// -------------------------------------------

        // Script 00
        // Dummy Script - Never Use and should never be called
        if (nSpawnTag == 0)
        {
            return sRetTemplate;
        }

		//sample. Gets the tag from a Ness Spawn Waypoint Local variable
        if (nSpawnTag == 1)
        {
			sRetTemplate = GetLocalString(oSpawn, "NessTag");
		}

// -------------------------------------------
// Only Make Modifications Between These Lines
//
	}
//	SendMessageToPC(GetFirstPC(), "**FLAG tag returned is " + sRetTemplate + " and the number is " + IntToString(nSpawnTag));
    return sRetTemplate;
}