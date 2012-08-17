#include "acr_spawn_i"

void main();

// Created by Riotnrrd for ALFA 4/2012
void main() {
	int nWolves = d10() + 6;
	int i;
	
	for (i = 0; i < nWolves; i++) ACR_SpawnObject("abr_cr_an_wild_wolf", OBJECT_TYPE_CREATURE);
}