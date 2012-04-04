//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//

string GetTemplateByCR(int nCR, string sGroupType)
{
string sRetTemplate;

if (sGroupType == "outdoor")
{
switch (nCR)
{
case 1:
switch(d6(1))
{
case 1: sRetTemplate = "tg_cr_pirate01"; break;
case 2: sRetTemplate = "tg_cr_pirate02"; break;
case 3: sRetTemplate = "tg_cr_pirate03"; break;
case 4: sRetTemplate = "tg_cr_pirate04"; break;
case 5: sRetTemplate = "tg_cr_pirate04a"; break;
case 6: sRetTemplate = "tg_cr_pirate06"; break;
}
break;
case 2:
switch(d4(1))
{
case 1: sRetTemplate = "tg_cr_kobrunt04"; break;
case 2: sRetTemplate = "tg_cr_kobrunt05"; break;
case 3: sRetTemplate = "tg_cr_kobscou04"; break;
case 4: sRetTemplate = "tg_cr_kobfig05"; break;
}
break;
case 3:
switch(d4(1))
{
case 1: sRetTemplate = "tg_cr_tinyfirebet"; break;
case 2: sRetTemplate = "tg_cr_tinyfirebetspit"; break;
case 3: sRetTemplate = "tg_tybombbet"; break;
case 4: sRetTemplate = "tg_cr_smfirebet"; break;
}
break;
case 4:
switch(d4(1))
{
case 1: sRetTemplate = "tg_bear"; break;
case 2: sRetTemplate = "tg_dogwolf1"; break;
case 3: sRetTemplate = "tg_dogwolf"; break;
case 4: sRetTemplate = "tg_dogwolf0"; break;
}
break;
default:
sRetTemplate = "";
break;
}
}

else if (sGroupType == "crypt")
{
switch (nCR)
{
case 1:
switch(d4(1))
{
case 1:
case 2: sRetTemplate = "NW_SKELETON"; break;
case 3: sRetTemplate = "NW_ZOMBIE01"; break;
case 4: sRetTemplate = "NW_ZOMBIE02"; break;
}
break;
case 2:
sRetTemplate = "NW_GHOUL";
break;
case 3:
sRetTemplate = "NW_SHADOW";
break;
default:
sRetTemplate = "";
break;
} }

else
{
// unknown group type
sRetTemplate = "";
}

return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
float fCR, fEquivSq, fTemp;

if (fEquiv == 0.0)
{
return 0.0;
}

fEquivSq = fEquiv * fEquiv;
fTemp = log(fEquivSq);
fTemp /= log(2.0);
fCR = fEncounterLevel + fTemp;

return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
if (fCR > fEncounterLevel || fCR < 1.0)
{
return 1.;
}

float fEquiv, fExponent, fDenom;

fExponent = fEncounterLevel - fCR;
fExponent *= 0.5;
fDenom = pow(2.0, fExponent);
fEquiv = 1.0 / fDenom;

return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
// Initialize
string sRetTemplate;

// Initialize Values
int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------

if (GetStringLeft(sTemplate, 7) == "scaled_")
{
float fEncounterLevel;
int nScaledInProgress = GetLocalInt(oSpawn, "ScaledInProgress");
string sGroupType = GetStringRight(sTemplate,
GetStringLength(sTemplate) - 7);

// First Time in for this encounter?
if (! nScaledInProgress)
{

// First time in - find the party level
int nTotalPCs = 0;
int nTotalPCLevel = 0;

object oArea = GetArea(OBJECT_SELF);

object oPC = GetFirstObjectInArea(oArea);
while (oPC != OBJECT_INVALID)
{
if (GetIsPC(oPC) == TRUE)
{
nTotalPCs++;
nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
}
oPC = GetNextObjectInArea(oArea);
}
if (nTotalPCs == 0)
{
fEncounterLevel = 0.0;
}
else
{
fEncounterLevel = IntToFloat(nTotalPCLevel) / IntToFloat(nTotalPCs);
}

// Save this for subsequent calls
SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);

// We're done when the CRs chosen add up to the
// desired encounter level
SetLocalInt(oSpawn, "ScaledCallCount", 0);
SetLocalInt(oSpawn, "ScaledInProgress", TRUE);
}


fEncounterLevel = GetLocalFloat(oSpawn, "ScaledEncounterLevel");
int nScaledCallCount = GetLocalInt(oSpawn, "ScaledCallCount");

// For simplicity, I'm not supporting creatures with CR < 1.0)
if (fEncounterLevel < 1.0)
{
// We're done... No creatures have CR low enough to add to this encounter
sRetTemplate = "";
}

else
{
// randomly choose a CR at or below the remaining (uncovered) encounter
// level
int nCR = Random(FloatToInt(fEncounterLevel)) + 1;

// cap to the largest CR we currently support in GetTemplateByCR
if (nCR > 3)
{
nCR = 3;
}

sRetTemplate = GetTemplateByCR(nCR, sGroupType);


// Convert CR to Encounter Level equivalent so it can be correctly
// subtracted. This does the real scaling work
float fELEquiv = ConvertCRToELEquiv(IntToFloat(nCR), fEncounterLevel);
float fElRemaining = 1.0 - fELEquiv;

fEncounterLevel = ConvertELEquivToCR(fElRemaining, fEncounterLevel);
SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);
}

nScaledCallCount++;
SetLocalInt(oSpawn, "ScaledCallCount", nScaledCallCount);

nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

if (nScaledCallCount >= nSpawnNumber)
{
// reset...
SetLocalInt(oSpawn, "ScaledInProgress", FALSE);
}
}

// mixed goblins
if (sTemplate == "mix_gobs")
{
switch(d6(1))
{
case 1:
sRetTemplate = "tg_cr_gobwar05";
break;
case 2:
sRetTemplate = "tg_cr_gobwar03";
break;
case 3:
sRetTemplate = "tg_cr_gobwar01";
break;
case 4:
sRetTemplate = "tg_cr_gobfight05";
break;
case 5:
sRetTemplate = "tg_cr_gobel02";
break;
case 6:
sRetTemplate = "tg_cr_gobsham";
break;
}
}

// mixed undead
if (sTemplate == "undeadlow")
{
switch(d8(1))
{
case 1:
sRetTemplate = "tg_cr_zombie01";
break;
case 2:
sRetTemplate = "tg_cr_zombie04";
break;
case 3:
sRetTemplate = "tg_cr_zombiemil01";
break;
case 4:
sRetTemplate = "tg_cr_skeleton04";
break;
case 5:
sRetTemplate = "tg_cr_skeletonraid04";
break;
case 6:
sRetTemplate = "tg_cr_zombiesol02";
break;
case 7:
sRetTemplate = "tg_cr_zombie02";
break;
case 8:
sRetTemplate = "tg_cr_zombiemil04";
break;
}
}
//

// mixed bandits
if (sTemplate == "mix_pirates")
{
switch(d6(1))
{
case 1:
sRetTemplate = "tg_cr_pirate02";
break;
case 2:
sRetTemplate = "tg_cr_pirate03";
break;
case 3:
sRetTemplate = "tg_cr_pirate01";
break;
case 4:
sRetTemplate = "tg_cr_pirate07";
break;
case 5:
sRetTemplate = "tg_cr_pirate04";
break;
case 6:
sRetTemplate = "tg_cr_pirate05";
break;
}
}
//
// Special bandits
if (sTemplate == "pirate_spec")
{
switch(d2(1))
{
case 1:
sRetTemplate = "tg_cr_pirate06";
break;
case 2:
sRetTemplate = "tg_cr_pirate08";
break;
}
}
//

// amnwater guards
if (sTemplate == "awguards")
{
switch(d6(1))
{
case 1:
sRetTemplate = "tg_amnianguard01";
break;
case 2:
sRetTemplate = "tg_amnianguard02";
break;
case 3:
sRetTemplate = "tg_amnianguard03";
break;
case 4:
sRetTemplate = "tg_amnianguard04";
break;
case 5:
sRetTemplate = "tg_amnianguard05";
break;
case 6:
sRetTemplate = "tg_amnianguard06";
break;
}
}
//

//adventurer group
if (sTemplate == "advengroup")
{
switch(d8())
{
case 1:
sRetTemplate = "exodus_pirate04";
break;
case 2:
sRetTemplate = "tg_cr_dwarf2";
break;
case 3:
sRetTemplate = "exodus_pirate06";
break;
case 4:
sRetTemplate = "tg_cr_halfling1";
break;
case 5:
sRetTemplate = "c_st01_desertthug02";
break;
case 6:
sRetTemplate = "c_st01_desertthug03";
break;
case 7:
sRetTemplate = "c_st01_desertfighter02";
break;
case 8:
sRetTemplate = "c_st01_desertscout02";
break;
}
}
//

// Hillbrook gnomes and halflings
if (sTemplate == "hillfolk")
{
switch(d10(1))
{
case 1:
sRetTemplate = "exodus_gnomef2";
break;
case 2:
sRetTemplate = "exodus_halfling";
break;
case 3:
sRetTemplate = "exodus_gnome";
break;
case 4:
sRetTemplate = "exodus_gnome1";
break;
case 5:
sRetTemplate = "exodus_gnomem2";
break;
case 6:
sRetTemplate = "exodus_gnomem1";
break;
case 7:
sRetTemplate = "exodus_halflingf2";
break;
case 8:
sRetTemplate = "exodus_halfling1";
break;
case 9:
sRetTemplate = "tg_cr_halfling2";
break;
case 10:
sRetTemplate = "exodus_halfling3";
break;
}
}
//

// night owls
if (sTemplate == "nightowls")
{
switch(d8(1))
{
case 1:
sRetTemplate = "c_cat";
break;
case 2:
sRetTemplate = "exodus_begger01";
break;
case 3:
sRetTemplate = "exodus_strangeman1";
break;
case 4:
sRetTemplate = "exodus_strangeman4";
break;
case 5:
sRetTemplate = "exodus_drunkman";
break;
case 6:
sRetTemplate = "exodus_whore";
break;
case 7:
sRetTemplate = "exodus_whore02";
break;
case 8:
sRetTemplate = "exodus_pirate0s";
break;
}
}
//

// high flyers
if (sTemplate == "noblemix")
{
switch(d8(1))
{
case 1:
sRetTemplate = "amn_noble1";
break;
case 2:
sRetTemplate = "amn_noble2";
break;
case 3:
sRetTemplate = "amn_noble3";
break;
case 4:
sRetTemplate = "amn_noblef4";
break;
case 5:
sRetTemplate = "amn_noblef3";
break;
case 6:
sRetTemplate = "amn_noblef2";
break;
case 7:
sRetTemplate = "c_st01_desertmerchant4";
break;
case 8:
sRetTemplate = "c_st01_desertmerchant04";
break;
}
}
//

// bar npcs
if (sTemplate == "barnpcs")
{
switch(d12(1))
{
case 1:
sRetTemplate = "exodus_amnmerch";
break;
case 2:
sRetTemplate = "skaug_commoner_16";
break;
case 3:
sRetTemplate = "skaug_commoner_13";
break;
case 4:
sRetTemplate = "skaug_commoner_12";
break;
case 5:
sRetTemplate = "skaug_commoner_11";
break;
case 6:
sRetTemplate = "skaug_commoner_09";
break;
case 7:
sRetTemplate = "skaug_commoner_14";
break;
case 8:
sRetTemplate = "skaug_commoner_15";
break;
case 9:
sRetTemplate = "exodus_fisherman1";
break;
case 10:
sRetTemplate = "exodus_corsiar1b";
break;
case 11:
sRetTemplate = "exodus_drunkman";
break;
case 12:
sRetTemplate = "exodus_whore";
break;
}
}
//

// bar npcs2
if (sTemplate == "sitnpcs")
{
switch(d12(1))
{
case 1:
sRetTemplate = "exodus_patron1";
break;
case 2:
sRetTemplate = "exodus_patron2";
break;
case 3:
sRetTemplate = "exodus_patron3";
break;
case 4:
sRetTemplate = "exodus_patron4";
break;
case 5:
sRetTemplate = "exodus_patron5";
break;
case 6:
sRetTemplate = "exodus_patron9";
break;
case 7:
sRetTemplate = "exodus_patron8";
break;
case 8:
sRetTemplate = "exodus_patron7";
break;
case 9:
sRetTemplate = "exodus_patron6";
break;
case 10:
sRetTemplate = "exodus_patron10";
break;
case 11:
sRetTemplate = "exodus_patron11";
break;
case 12:
sRetTemplate = "exodus_patron12";
break;
}
}
//

// town npcs
if (sTemplate == "townnpcs")
{
switch(d20(1))
{
case 1:
sRetTemplate = "exodus_amnmerch";
break;
case 2:
sRetTemplate = "skaug_commoner_16";
break;
case 3:
sRetTemplate = "exodus_child1";
break;
case 4:
sRetTemplate = "skaug_commoner_12";
break;
case 5:
sRetTemplate = "skaug_commoner_11";
break;
case 6:
sRetTemplate = "skaug_commoner_09";
break;
case 7:
sRetTemplate = "skaug_commoner_14";
break;
case 8:
sRetTemplate = "exodus_child";
break;
case 9:
sRetTemplate = "exodus_fisherman1";
break;
case 10:
sRetTemplate = "amn_noble2";
break;
case 11:
sRetTemplate = "exodus_drunkman";
break;
case 12:
sRetTemplate = "amn_noble1";
break;
case 13:
sRetTemplate = "amn_noblef4";
break;
case 14:
sRetTemplate = "amn_noble4";
break;
case 15:
sRetTemplate = "c_st01_desertmerchant5";
break;
case 16:
sRetTemplate = "amn_noblef2";
break;
case 17:
sRetTemplate = "exodus_halfling";
break;
case 18:
sRetTemplate = "exodus_halfling1";
break;
case 19:
sRetTemplate = "exodus_slave1";
break;
case 20:
sRetTemplate = "exodus_sailornpc01";
break;
}
}
//

// eshpurta town npcs
if (sTemplate == "eshnpcs")
{
switch(d20(1))
{
case 1:
sRetTemplate = "yg_eshpurtacommoner5";
break;
case 2:
sRetTemplate = "skaug_commoner_16";
break;
case 3:
sRetTemplate = "exodus_child1";
break;
case 4:
sRetTemplate = "skaug_commoner_12";
break;
case 5:
sRetTemplate = "skaug_commoner_11";
break;
case 6:
sRetTemplate = "skaug_commoner_09";
break;
case 7:
sRetTemplate = "skaug_commoner_14";
break;
case 8:
sRetTemplate = "exodus_child";
break;
case 9:
sRetTemplate = "exodus_fisherman1";
break;
case 10:
sRetTemplate = "yg_eshpurtacommoner2";
break;
case 11:
sRetTemplate = "exodus_drunkman";
break;
case 12:
sRetTemplate = "yg_eshpurtacommoner1";
break;
case 13:
sRetTemplate = "yg_eshpurtacommoner6";
break;
case 14:
sRetTemplate = "yg_eshpurtacommoner3";
break;
case 15:
sRetTemplate = "c_st01_desertmerchant5";
break;
case 16:
sRetTemplate = "yg_eshpurtacommoner4";
break;
case 17:
sRetTemplate = "exodus_halfling";
break;
case 18:
sRetTemplate = "exodus_halfling1";
break;
case 19:
sRetTemplate = "exodus_slave1";
break;
case 20:
sRetTemplate = "yg_eshpurtblacksmith1";
break;
}
}
//

// pg_guard
if (sTemplate == "gobspell")
{
switch(d3(1))
{
case 1:
sRetTemplate = "tg_cr_gobsham";
break;
case 2:
sRetTemplate = "tg_cr_gobsorc";
break;
case 3:
sRetTemplate = "tg_cr_gobchief";
break;
}
}
//

//RATS!
if (sTemplate == "mix_rats")
{
switch(d2(1))
{
case 1:
sRetTemplate = "exodus_sewerrat01";
break;
case 2:
sRetTemplate = "exodus_sewerrat02";
break;
}
}
//

//ASH RATS!
if (sTemplate == "ashrats")
{
switch(d2(1))
{
case 1:
sRetTemplate = "exodus_ashrat";
break;
case 2:
sRetTemplate = "exodus_ashrat1";
break;
}
}
//

//Wolves!
if (sTemplate == "wolves")
{
switch(d3(1))
{
case 1:
sRetTemplate = "tg_dogwolf";
break;
case 2:
sRetTemplate = "tg_dogwolf0";
break;
case 3:
sRetTemplate = "tg_dogwolf1";
break;
}
}
//

//Spiders!
if (sTemplate == "low_spiders")
{
switch(d6(1))
{
case 1:
sRetTemplate = "abr_cr_vm_spider_tinyhunt";
break;
case 2:
sRetTemplate = "tg_cr_smspid";
break;
case 3:
sRetTemplate = "tg_cr_tnspid";
break;
case 4:
sRetTemplate = "abr_cr_vm_spider_smallhunt";
break;
case 5:
sRetTemplate = "abr_cr_vm_spider_small";
break;
case 6:
sRetTemplate = "abr_cr_vm_spider_tiny";
break;
}
}
//
//Larger Spiders!
if (sTemplate == "med_spiders")
{
switch(d6(1))
{
case 1:
sRetTemplate = "tg_cr_medspid";
break;
case 2:
sRetTemplate = "tg_cr_smspid";
break;
case 3:
sRetTemplate = "tg_cr_tnspid";
break;
case 4:
sRetTemplate = "abr_cr_vm_spider_smallhunt";
break;
case 5:
sRetTemplate = "tg_cr_lgspid";
break;
case 6:
sRetTemplate = "tg_cr_mddirespid";
break;
}
}
//

//Low level gobs
if (sTemplate == "four_goblins")
{
switch(d4())
{
case 1:
sRetTemplate = "tg_cr_gobrun04";
break;
case 2:
sRetTemplate = "tg_cr_gobrun05";
break;
case 3:
sRetTemplate = "tg_cr_gobscout05";
break;
case 4:
sRetTemplate = "tg_cr_gobscout03";
break;
}
}

//Low level gobs
if (sTemplate == "cavegoblins")
{
switch(d10())
{
case 1:
sRetTemplate = "abr_cr_hu_goblinwarrior02";
break;
case 2:
sRetTemplate = "abr_cr_hu_goblinwarrior01";
break;
case 3:
sRetTemplate = "abr_cr_hu_goblinscout01";
break;
case 4:
sRetTemplate = "abr_cr_hu_goblinscout05";
break;
case 5:
sRetTemplate = "abr_cr_hu_goblinrunner01";
break;
case 6:
sRetTemplate = "abr_cr_hu_goblinrunner03";
break;
case 7:
sRetTemplate = "abr_cr_hu_goblinelite04";
break;
case 8:
sRetTemplate = "abr_cr_hu_goblinelite01";
break;
case 9:
sRetTemplate = "abr_cr_hu_goblinsorcerer";
break;
case 10:
sRetTemplate = "abr_cr_hu_goblinshaman";
break;
}
}

//Orcs
if (sTemplate == "orcgroup")
{
switch(d10())
{
case 1:
sRetTemplate = "abr_cr_hu_orcbasher01";
break;
case 2:
sRetTemplate = "abr_cr_hu_orcfighter02";
break;
case 3:
sRetTemplate = "abr_cr_hu_orcambusher03";
break;
case 4:
sRetTemplate = "abr_cr_hu_orcambusher01";
break;
case 5:
sRetTemplate = "abr_cr_hu_orcwarrior04";
break;
case 6:
sRetTemplate = "abr_cr_hu_orcwarrior03";
break;
case 7:
sRetTemplate = "abr_cr_hu_orcbattlepriest";
break;
case 8:
sRetTemplate = "abr_cr_hu_orcbasher04";
break;
case 9:
sRetTemplate = "abr_cr_hu_orcfighter03";
break;
case 10:
sRetTemplate = "abr_cr_hu_orcfighter01";
break;
}
}

//Low level lizards
if (sTemplate == "lizards_mob")
{
switch(d4())
{
case 1:
sRetTemplate = "exodus_lizardman02";
break;
case 2:
sRetTemplate = "exodus_lizardman03";
break;
case 3:
sRetTemplate = "exodus_lizardman04";
break;
case 4:
sRetTemplate = "exodus_lizardman05";
break;
}
}
//

//Kobolds
if (sTemplate == "koboldgroup")
{
switch(d6())
{
case 1:
sRetTemplate = "abr_cr_hu_koboldrunt01";
break;
case 2:
sRetTemplate = "abr_cr_hu_koboldscout05";
break;
case 3:
sRetTemplate = "abr_cr_hu_koboldfighter02";
break;
case 4:
sRetTemplate = "abr_cr_hu_koboldrunt03";
break;
case 5:
sRetTemplate = "abr_cr_hu_koboldroughneck";
break;
case 6:
sRetTemplate = "abr_cr_hu_koboldscout02";
break;
}
}
//

//high level lizards
if (sTemplate == "lizards_high")
{
switch(d3())
{
case 1:
sRetTemplate = "exodus_lizardman01";
break;
case 2:
sRetTemplate = "exodus_lizardman07";
break;
case 3:
sRetTemplate = "exodus_lizardman08";
break;
case 4:
sRetTemplate = "exodus_lizardman06";
break;
}
}
//
//Stink and Bomb
if (sTemplate == "green_beetles")
{
switch(d3(1))
{
case 1:
sRetTemplate = "tg_smbombbet";
break;
case 2:
sRetTemplate = "tg_smstinkbet";
break;
case 3:
sRetTemplate = "tg_smbombbet";
break;
}
}
//

//Mob of Beetles
if (sTemplate == "mob_beetles")
{
switch(d8())
{
case 1:
sRetTemplate = "tg_cr_tinyfirebet";
break;
case 2:
sRetTemplate = "tg_tybombbet5";
break;
case 3:
sRetTemplate = "tg_smstinkbet";
break;
case 4:
sRetTemplate = "tg_smstinkbet";
break;
case 5:
sRetTemplate = "tg_cr_smfirebetspit";
break;
case 6:
sRetTemplate = "tg_smbombbett";
break;
case 7:
sRetTemplate = "tg_cr_tinyfirebetspitt";
break;
case 8:
sRetTemplate = "tg_cr_smfirebet";
break;
}
}
//

//scraef group
if (sTemplate == "scraefgroup")
{
switch(d12())
{
case 1:
sRetTemplate = "exodus_pirate04";
break;
case 2:
sRetTemplate = "tg_cr_dwarf2";
break;
case 3:
sRetTemplate = "exo_npc_hyd_lamplighter2";
break;
case 4:
sRetTemplate = "exo_npc_hyd_bladeweg";
break;
case 5:
sRetTemplate = "exo_npc_hyd_cuffs2";
break;
case 6:
sRetTemplate = "c_st01_desertthug03";
break;
case 7:
sRetTemplate = "exodus_pirate06";
break;
case 8:
sRetTemplate = "exo_npc_hyd_scarlette0";
break;
case 9:
sRetTemplate = "exo_npc_hyd_cuffs";
break;
case 10:
sRetTemplate = "exo_npc_hyd_lamplighter1";
break;
case 11:
sRetTemplate = "exo_npc_hyd_bladeweg1";
break;
case 12:
sRetTemplate = "exo_npc_hyd_legcutter";
break;
}
}
//

// Goblins and Boss
if (sTemplate == "gobsnboss")
{
int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
if (nIsBossSpawned == TRUE)
{
// Find the Boss
object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

// Check if Boss is Alive
if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
{
// He's alive, spawn a Peon to keep him Company
sRetTemplate = "NW_GOBLINA";
}
else
{
// He's dead, Deactivate Camp!
SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
}
}
else
{
// No Boss, so Let's Spawn Him
sRetTemplate = "NW_GOBCHIEFA";
SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
}
}
//

// Scaled Encounter
if (sTemplate == "scaledundead")
{
// Initialize Variables
int nTotalPCs;
int nTotalPCLevel;
int nAveragePCLevel;
object oArea = GetArea(OBJECT_SELF);

// Cycle through PCs in Area
object oPC = GetFirstObjectInArea(oArea);
while (oPC != OBJECT_INVALID)
{
if (GetIsPC(oPC) == TRUE)
{
nTotalPCs++;
nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
}
oPC = GetNextObjectInArea(oArea);
}
if (nTotalPCs == 0)
{
nAveragePCLevel = 0;
}
else
{
nAveragePCLevel = nTotalPCLevel / nTotalPCs;
}

// Select a Creature to Spawn
switch (nAveragePCLevel)
{
// Spawn Something with CR 1
case 1:
sRetTemplate = "tg_cr_skeletonraid02";
break;
//
// Spawn Something with CR 2
case 2:
sRetTemplate = "tg_cr_skeletonpat01";
break;
//
// Spawn Something with CR 3
case 3:
sRetTemplate = "tg_cr_scorchedskull";
break;
//
// Spawn Something with CR 4
case 4:
sRetTemplate = "tg_cr_allip";
break;
//
// Spawn Something with CR 5
case 5:
sRetTemplate = "tg_cr_skeletonhero";
break;
//
}
}
//

// Pirates and Boss
if (sTemplate == "pirates")
{
// Delay the Spawn for 45 Minutes
if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
{
if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
{
// Start the Delay
SetLocalInt(oSpawn, "DelayStarted", TRUE);
DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
}
sRetTemplate = "";
return sRetTemplate;
}
int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
if (nIsBossSpawned == TRUE)
{
// Find the Boss
object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

// Check if Boss is Alive
if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
{
// He's alive, spawn a Peon to keep him Company
sRetTemplate = "NW_GOBLINA";
}
else
{
// He's dead, Deactivate Camp!
SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
}
}
else
{
// No Boss, so Let's Spawn Him
sRetTemplate = "NW_GOBCHIEFA";
SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
}
}
//

// Advanced Scaled Encounter
if (sTemplate == "advscaled")
{
//Initalize Variables
int nTotalPCs;
int nTotalPCLevel;
int nAveragePCLevel;
object oArea = GetArea(OBJECT_SELF);

//Cycle through PCs in area
object oPC = GetFirstObjectInArea(oArea);
while (oPC != OBJECT_INVALID)
{
if (GetIsPC(oPC) == TRUE)
{
nTotalPCs++;
nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
}
oPC = GetNextObjectInArea(oArea);
}
if (nTotalPCs == 0)
{
nAveragePCLevel = 0;
}
else
{
nAveragePCLevel = nTotalPCLevel / nTotalPCs;
}

//Select a Creature to Spawn
switch (nAveragePCLevel)
{
//Spawn Something with CR 1
case 1:
switch (d6())
{
case 1: sRetTemplate = "cr1example1";
case 2: sRetTemplate = "cr1example2";
case 3: sRetTemplate = "cr1example3";
case 4: sRetTemplate = "cr1example4";
case 5: sRetTemplate = "cr1example5";
case 6: sRetTemplate = "cr1example6";
}
break;
}
}
//

// Encounters
if (sTemplate == "encounter")
{
// Declare Variables
int nCounter, nCounterMax;
string sCurrentTemplate;

// Retreive and Increment Counter
nCounter = GetLocalInt(oSpawn, "GroupCounter");
nCounterMax = GetLocalInt(oSpawn, "CounterMax");
nCounter++;

// Retreive CurrentTemplate
sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

// Check CounterMax
if (nCounter > nCounterMax)
{
sCurrentTemplate = "";
nCounter = 1;
}

if (sCurrentTemplate != "")
{
// Spawn Another CurrentTemplate
sRetTemplate = sCurrentTemplate;
}
else
{
// Choose New CurrentTemplate and CounterMax
switch (Random(2))
{
// Spawn 1-4 NW_DOGs
case 0:
sRetTemplate = "NW_DOG";
nCounterMax = Random(4) + 1;
break;
}
// Record New CurrentTemplate and CounterMax
SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
SetLocalInt(oSpawn, "CounterMax", nCounterMax);
}

// Record Counter
SetLocalInt(oSpawn, "GroupCounter", nCounter);
}
//

//
if (sTemplate == "kobolds")
{
int nKobold = Random(6) + 1;
sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
}
//
//Sily's Groups
if (sTemplate == "sily_goblin_scout")
{
switch(d2(1))
{
case 1:
sRetTemplate = "an_goblin";
break;
case 2:
sRetTemplate = "an_goblin2";
break;
}
}


// -------------------------------------------
// Only Make Modifications Between These Lines
//
return sRetTemplate;
}