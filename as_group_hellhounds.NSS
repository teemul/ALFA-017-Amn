#include "acr_spawn_i"

void main();

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nHounds = d2();
	int i;
	
	for (i = 0; i < nHounds; i++) ACR_SpawnObject("abr_cr_ou_hellhound", OBJECT_TYPE_CREATURE);
}