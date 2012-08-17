#include "acr_spawn_i"

void main();

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nGargoyles = d2();
	int i;
	
	for (i = 0; i < nGargoyles; i++) ACR_SpawnObject("abr_cr_mh_gargoyle", OBJECT_TYPE_CREATURE);
}