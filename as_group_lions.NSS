#include "acr_spawn_i"

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nLions = d2();
	int i;
	
	for (i = 0; i < nLions; i++) ACR_SpawnObject("abr_cr_an_lion", OBJECT_TYPE_CREATURE);
}