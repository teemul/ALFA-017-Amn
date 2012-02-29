//::///////////////////////////////////////////////////////////////////////////
//::
//::	ga_henchman_add
//::
//::	Adds a target creature to your party as a henchman (not a companion).
//::
//::        Parameters:
//::			sTarget - tag of the creature you want to add
//::			bForce  - if set to 1, sTarget will be added even if player already has maximum henchman
//::			sMaster - The Creature you are adding the henchman to (default is PC Speaker)
//::            bOverrideBehavior - if set to 1, sTarget's event handlers (scripts) will be replaced with henchman ones.
//::
//::///////////////////////////////////////////////////////////////////////////
// DBR 1/28/06
//:: Adds the speaking NPC as henchman to the speaking PC
// T-Ice 4 Feb. 09

#include "ginc_param_const"
#include "ginc_henchman"



void main(int bForce, int bOverrideBehavior)
{
	object oMaster,oHench;
	
	oMaster=(GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
	oHench =OBJECT_SELF;

	HenchmanAdd(oMaster,oHench,bForce,bOverrideBehavior);


}