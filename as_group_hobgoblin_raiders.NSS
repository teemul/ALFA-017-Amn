#include "acr_spawn_i"

void main();

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nHobgoblins = d6() + 3;
	int nFighters = d2();
	int nWolves = d2();
	int i;
	
	for (i = 0; i < nHobgoblins; i++) ACR_SpawnObject("abr_cr_hu_hobgoblin", OBJECT_TYPE_CREATURE);
	for (i = 0; i < nFighters; i++) ACR_SpawnObject("abr_cr_hu_hobgoblin_ftr2", OBJECT_TYPE_CREATURE);
	for (i = 0; i < nWolves; i++) ACR_SpawnObject("abr_cr_an_direwolf", OBJECT_TYPE_CREATURE);
}