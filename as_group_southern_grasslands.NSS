#include "acr_spawn_i"

void main();
// Created by Riotnrrd for ALFA 8/2012
// Southern Grasslands Encounters
// EL 2-6

/* 
Day:
Annis (hag) 1
Basilisk 3
Barghest Pack 3
cheetah 3
dire rat 4
dragon 8
gargoyle 3
gholl hunters 4
goblin patrol 4
goblin raiders 4
green hag 1
lightfoot scouts 5
hellhound 3
hobgoblin raiders 3
Lions 7
NPCs 11
Nomads 14
Ogre 4
Orc Patrol 4
Troll 3
Wolf 8

Night:
Allip 1
Annis (hag) 4
Baneguard 1
Barghest pack 2 
cheetah 2
darkenbeast 2
dire rat 3
dragon 6
gargoyles 2
ghast gang 2
ghoul gang 2
gnoll hunters 3
goblin patrol 3
goblin raiders 3
greenhag (hag) 2
lightfoot scouts 2
hell hound 4
hobgoblin raiders 4
lion 2
NPCs 9 
nightmare 2
nomads 6
ogre 4
orc patrol 7
shadow 2
shadow mastiff 2
spectral panther 2
troll 2
vampire spawn 2
wight 2
wolf 5
wraith 1
zombie 2
*/

void main() {

	int nRoll = d100();
	int i;

	if (GetIsDay()) 
	{
		if (nRoll <= 1) ACR_SpawnObject("abr_cr_mh_annis", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 4) ACR_SpawnObject("abr_cr_mb_basilisk", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 7) ACR_SpawnGroup("barghest_pack");
		else if (nRoll <= 10) ACR_SpawnGroup("cheetah_family");
		else if (nRoll <= 14) ACR_SpawnGroup("dire_rat_pack");
		else if (nRoll <= 22) ACR_SpawnObject("", OBJECT_TYPE_CREATURE); // NEED TO CREATE
		else if (nRoll <= 25) ACR_SpawnGroup("gargoyles");
		else if (nRoll <= 29) ACR_SpawnGroup("gnoll_hunters");
		else if (nRoll <= 33) ACR_SpawnGroup("goblin_patrol");
		else if (nRoll <= 37) ACR_SpawnGroup("goblin_raiders");
		else if (nRoll <= 38) ACR_SpawnObject("abr_cr_mh_greenhag", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 43) ACR_SpawnGroup("halfling_scouts");
		else if (nRoll <= 46) ACR_SpawnGroup("hellhounds");
		else if (nRoll <= 49) ACR_SpawnGroup("hobgoblin_raiders");
		else if (nRoll <= 56) ACR_SpawnGroup("lions");
		else if (nRoll <= 67) ACR_SpawnGroup("adventurers");
		else if (nRoll <= 81) ACR_SpawnGroup("nomads"); // NEED TO CREATE nomads
		else if (nRoll <= 85) ACR_SpawnGroup("ogre_gang");
		else if (nRoll <= 89) ACR_SpawnGroup("orc_patrol");
		else if (nRoll <= 92) ACR_SpawnGroup(""); //NEED TO CREATE trolls
		else ACR_SpawnGroup("wolf_pack");
	}
	else	// Is night
	{
/*	
Allip 1
Annis (hag) 4
Baneguard 1
Barghest pack 2 
cheetah 2
darkenbeast 2
dire rat 3
dragon 6
gargoyle 2
ghast gang 2
ghoul gang 2
gnoll hunters 3
goblin patrol 3
goblin raiders 3
greenhag (hag) 2
lightfoot scouts 2
hell hound 4
hobgoblin raiders 4
lion 2
NPCs 9 
nightmare 2
nomads 6
ogre 4
orc patrol 7
shadow 2
shadow mastiff 2
spectral panther 2
troll 2
vampire spawn 2
wight 2
wolf 5
wraith 1
zombie 2
*/

		if (nRoll <= 3) ACR_SpawnObject("", OBJECT_TYPE_CREATURE); // NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnObject("abr_cr_mh_annis", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 6) ACR_SpawnObject("abr_cr_un_baneguard", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 6) ACR_SpawnGroup("barghest_pack");
		else if (nRoll <= 6) ACR_SpawnGroup("cheetah_family");
		else if (nRoll <= 6) ACR_SpawnObject("", OBJECT_TYPE_CREATURE); // NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnGroup("dire_rat_pack");
		else if (nRoll <= 6) ACR_SpawnGroup(""); // NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnGroup("gargoyles");
		else if (nRoll <= 6) ACR_SpawnGroup("ghast_gang");
		else if (nRoll <= 6) ACR_SpawnGroup("ghoul_gang");
		else if (nRoll <= 6) ACR_SpawnGroup("gnoll_hunters");
		else if (nRoll <= 6) ACR_SpawnGroup("goblin_patrol");
		else if (nRoll <= 6) ACR_SpawnGroup("goblin_raiders");
		else if (nRoll <= 6) ACR_SpawnObject("abr_cr_mh_greenhag", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 6) ACR_SpawnGroup("halfling_scouts");
		else if (nRoll <= 6) ACR_SpawnGroup("hellhounds");
		else if (nRoll <= 6) ACR_SpawnGroup("hobgoblin_raiders");
		else if (nRoll <= 6) ACR_SpawnGroup("lions");
		else if (nRoll <= 6) ACR_SpawnGroup("adventurers");
		else if (nRoll <= 6) ACR_SpawnObject("", OBJECT_TYPE_CREATURE); // NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnGroup("");// NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnGroup("ogre_gang");
		else if (nRoll <= 6) ACR_SpawnGroup("orc_patrol");
		else if (nRoll <= 6) ACR_SpawnGroup("shadow_gang");
		else if (nRoll <= 6) ACR_SpawnObject("abr_cr_ou_shadowmastiff", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 6) ACR_SpawnObject("", OBJECT_TYPE_CREATURE); // NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnObject("", OBJECT_TYPE_CREATURE); // NEED TO CREATE
		else if (nRoll <= 6) ACR_SpawnObject("abr_cr_un_vampirespawn", OBJECT_TYPE_CREATURE);
		else if (nRoll <= 6) ACR_SpawnGroup("wight_gang");
		else if (nRoll <= 6) ACR_SpawnGroup("wolf_pack");
		else if (nRoll <= 6) ACR_SpawnObject("abr_cr_un_wraith", OBJECT_TYPE_CREATURE);
		else ACR_SpawnGroup("zombies");
	}
}