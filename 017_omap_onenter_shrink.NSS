#include "acr_area_i"

void main () {

ACR_AreaOnEnter();

effect eSlow = EffectMovementSpeedDecrease(80);
effect eShrink = EffectSetScale(0.2);

effect eTravel = EffectLinkEffects(eSlow, eShrink);

object oEnterer = GetEnteringObject();

if (GetIsPC(oEnterer) && !GetIsDM(oEnterer)) {
   AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTravel, oEnterer));
}

SendMessageToPC(oEnterer, "You have entered area "+GetName(OBJECT_SELF));
}
