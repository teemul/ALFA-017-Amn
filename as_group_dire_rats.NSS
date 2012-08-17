
#include "acr_spawn_i"

void main();

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nRats = d6() + 2;
	int i;
	
	for (i = 0; i < nRats; i++) ACR_SpawnObject("abr_cr_an_direrat", OBJECT_TYPE_CREATURE);
}