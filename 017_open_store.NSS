// Open store
#include "ginc_param_const"
#include "ginc_item"

void main(string sTag){	
object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
OpenStore(GetTarget(sTag),oPC,0,0);
}