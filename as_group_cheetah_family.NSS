#include "acr_spawn_i"

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nCheetahs = d3() + 2;
	int i;
	
	for (i = 0; i < nCheetahs; i++) ACR_SpawnObject("abr_cr_an_cheetah", OBJECT_TYPE_CREATURE);
}