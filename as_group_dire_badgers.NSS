
#include "acr_spawn_i"

// Created by Riotnrrd for ALFA 4/2012
void main() {
	int nBadgers = d2();
	int i;
	
	for (i = 0; i < nBadgers; i++) ACR_SpawnObject("abr_cr_an_direbadger", OBJECT_TYPE_CREATURE);
}