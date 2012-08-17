
#include "acr_spawn_i"

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nBarghests = d2();
	int nGoblins = d4() + 4;
	int i;
	
	for (i = 0; i < nBarghests; i++) ACR_SpawnObject("abr_cr_ou_barghest", OBJECT_TYPE_CREATURE);
	for (i = 0; i < nGoblins; i++) ACR_SpawnObject("abr_cr_hu_goblin", OBJECT_TYPE_CREATURE);
}