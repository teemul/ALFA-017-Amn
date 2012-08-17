// Created by Riotnrrd for ALFA 4/2012

#include "acr_spawn_i"

void main();

void main() {
	int nImps = d2();
	int i;
	
	for (i = 0; i < nImps; i++) ACR_SpawnObject("abr_cr_ou_imp", OBJECT_TYPE_CREATURE);
}