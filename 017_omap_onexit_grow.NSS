#include "acr_area_i"

void main () {

ACR_AreaOnExit();

object oExiter = GetExitingObject();
effect eTest = GetFirstEffect(oExiter);

if (GetIsPC(oExiter) && !GetIsDM(oExiter)) {
   while (GetIsEffectValid(eTest)) {
      if (GetEffectCreator(eTest) == OBJECT_SELF) {
         SendMessageToPC(oExiter, "Removing "+IntToString(GetEffectType(eTest)));
         RemoveEffect(oExiter, eTest);
      }
      eTest = GetNextEffect(oExiter);
   }  
}

SendMessageToPC(oExiter, "You have left area "+GetName(OBJECT_SELF));
}