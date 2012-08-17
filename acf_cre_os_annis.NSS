// Created by Riotnrrd for ALFA 8/2012
// Simulates fog cloud effect

#include "acr_creature_i"

void main()
{
    ACR_CreatureOnSpawnIn();

	ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectConcealment(20, MISS_CHANCE_TYPE_VS_MELEE)), OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectConcealment(50, MISS_CHANCE_TYPE_VS_RANGED)), OBJECT_SELF);
}