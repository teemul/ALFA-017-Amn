#include "acr_spawn_i"

// Created by Riotnrrd for ALFA 8/2012
void main() {
	int nOgres = d3() +1;
	int i;
	
	for (i = 0; i < nOgres; i++) ACR_SpawnObject("abr_cr_gt_ogre", OBJECT_TYPE_CREATURE);
}