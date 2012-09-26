#include "acr_i"
#include "acr_pps_i"
#include "acr_time_i"
#include "acr_trigger_i"
void main();

void main(){
	
	int cooldown_hours=5;
	object player = GetFirstPC(1);
	int occupied=FALSE;
	int allowed=FALSE;
	int i=1;
	int skillcheck_scouting;
	int skillcheck_searching;
	object exhausted_player;
	object entering_PC=GetClickingObject();
	object oHunting_area=GetArea(GetTransitionTarget(OBJECT_SELF));
	SendMessageToPC(entering_PC,"debug: huntingarea="+GetName(oHunting_area));
	SendMessageToPC(entering_PC,"debug: enteringPC_ACR_ID="+IntToString(ACR_GetCharacterID(entering_PC)));
	//Check is the area empty
	while(GetIsObjectValid(player)){
		SendMessageToPC(entering_PC,"debug: this PC="+GetName(player)+" area="+GetName(GetArea(player)));
    	if(GetArea(player) == oHunting_area){
			SendMessageToPC(entering_PC,"debug: player area="+GetName(GetArea(player))+" hunting area="+GetName(oHunting_area)+" are the same");
			occupied=TRUE;
    	}
		else{
			SendMessageToPC(entering_PC,"debug: player area="+GetName(GetArea(player))+" hunting area="+GetName(oHunting_area)+" are different");
		}
    	player = GetNextPC(1);
	}

	if(occupied){
	//If the area is occupied, check if PC is on the current party list.
		int party_size=GetLocalInt(oHunting_area,"NumberOfPCs");
		for(i=1 ; i<=party_size ; i++){
			int party_member_ID=GetLocalInt(oHunting_area,"HuntingPartyMemberNumber"+IntToString(i)+"ID");
			SendMessageToPC(entering_PC,"debug: Partymember"+IntToString(i)+"_ID="+IntToString(party_member_ID));
			if(party_member_ID==ACR_GetCharacterID(entering_PC)){
				allowed=TRUE;
				SendMessageToPC(entering_PC,"Party hunts for monsters. "+GetName(GetFactionLeader(entering_PC))+" scouts.");
			}
		}		
		if(allowed==FALSE){
		//If the PC is not in the party currently occupying the area, port her out.
			//AssignCommand(entering_PC,JumpToLocation(GetLocation(GetWaypointByTag(GetLocalString(OBJECT_SELF,"ExitWaypointTag")))));
			SendMessageToPC(entering_PC,"((Area is currently occupied by another party, we apologise for your OoC inconvenience))");
			return;
		}
	}
	else{
	//If areas is not occupied, prepare a new encounter.

		//Clear current party list
		int party_size = GetLocalInt(oHunting_area,"NumberOfPCs");
		for(i=1 ; i<=party_size ; i++){
			DeleteLocalInt(oHunting_area,"HuntingPartyMemberNumber"+IntToString(i)+"ID");
		}
	
		//Find party leader and put all PCs in party to the current party list.
		allowed=TRUE;
		object party_leader=GetFactionLeader(entering_PC);
		//Demand that the party leader, the scout, goes in first
		if(party_leader!=entering_PC){
			SendMessageToPC(entering_PC,"Scout needs to go in first. ((Party leader is scout))");
			return;			
		}
		party_size=0;
		object player = GetFirstPC(1);
		while(GetIsObjectValid(player)){
    		if(GetFactionLeader(player) == party_leader){
				party_size=party_size+1;
				//Write down this party member to current party list.
				SetLocalInt(oHunting_area,"HuntingPartyMemberNumber"+IntToString(party_size)+"ID",ACR_GetCharacterID(player));
				//Check that player isn't affected by cooldown.				
				int last_time=GetLocalInt(oHunting_area,"LastVisitByPC"+IntToString(ACR_GetCharacterID(player)));
				SendMessageToPC(entering_PC,"Debug: Last time you were here was "+IntToString((ACR_GetGameHoursSinceStart()-last_time)) +"hours ago. Game has been running for "+IntToString(ACR_GetGameHoursSinceStart())+"hours.");
				if(((ACR_GetGameHoursSinceStart()-last_time)<cooldown_hours)&&(last_time!=0)){
					allowed=FALSE;
					exhausted_player=player;
				}
    		}
    		player = GetNextPC(1);
		}
		SendMessageToPC(entering_PC,"Debug: party size="+IntToString(party_size));
		//Soloers disallowed
		if(party_size==1){
			allowed=FALSE;
		}
		//If the party is not allowed to hunt, port the PC out and state reason
		if(allowed==FALSE){
			//AssignCommand(entering_PC,JumpToLocation(GetLocation(GetWaypointByTag(GetLocalString(OBJECT_SELF,"ExitWaypointTag")))));			
			if(party_size==1){
				SendMessageToPC(entering_PC,"You are not suicidal enough to venture to this dangerous terrain alone. ((Hunting areas aren't for soloers))");
			}
			else{
				SendMessageToPC(entering_PC,GetName(exhausted_player)+" is too tired to follow the party on this hunt. ((Cooldown pending))");
			}
			return;
		}
		//If the party is allowed to hunt, mark this as the last time they were here for each of them.
		if(allowed==TRUE){
			SetLocalInt(oHunting_area,"NumberOfPCs",party_size);
		    SendMessageToPC(entering_PC,"Party hunts for monsters. You scout.");
			object player = GetFirstPC(1);
			while(GetIsObjectValid(player)){
    			if(GetFactionLeader(player) == party_leader){
					SetLocalInt(oHunting_area,"LastVisitByPC"+IntToString(ACR_GetCharacterID(player)),ACR_GetGameHoursSinceStart());
				}
    			player = GetNextPC(1);
			}			
			//Make scouting check by the party leader
			skillcheck_scouting=GetSkillRank(SKILL_SURVIVAL,party_leader,FALSE)
				+GetSkillRank(SKILL_SPOT,party_leader,FALSE)
				+GetSkillRank(SKILL_LISTEN,party_leader,FALSE)
				+GetSkillRank(SKILL_HIDE,party_leader,FALSE)
				+GetSkillRank(SKILL_MOVE_SILENTLY,party_leader,FALSE)
				+d20(5);
			//SendMessageToPC(party_leader,"Debug: Your scouting rolls result to: "+IntToString(skillcheck_scouting));
			if(GetHasFeat(FEAT_TRACK,party_leader,TRUE)){
				skillcheck_scouting=skillcheck_scouting+5;
				SendMessageToPC(party_leader,"Debug: You haz the track feat!");
			}
			skillcheck_scouting=skillcheck_scouting/5;
			SendMessageToPC(party_leader,"Debug: Your scouting check result is: "+IntToString(skillcheck_scouting));
			SendMessageToPC(party_leader,"Debug: Area hunt DC is: "+IntToString(GetLocalInt(oHunting_area,"Hunting_DC_Monsters")));
			//Check if scouting check beats area DC. If yes activate creature spawns, if no deactivate.
			if(skillcheck_scouting>=GetLocalInt(oHunting_area,"Hunting_DC_Monsters")){
				object oInArea=GetFirstObjectInArea(oHunting_area);
				while(GetIsObjectValid(oInArea)){
					if(GetTag(oInArea)=="ACR_SPAWN_WP"){
						SendMessageToPC(party_leader,"Debug: Found waypoint and enabling if creature!");
						if(GetLocalInt(oInArea,"ACR_SPAWN_TYPE")==0){
							SetLocalInt(oInArea,"ACR_SPAWN_IS_DISABLED",0);
						}
					}
					oInArea=GetNextObjectInArea(oHunting_area);
				}
			}
			else{
				object oInArea=GetFirstObjectInArea(oHunting_area);
				while(GetIsObjectValid(oInArea)){
					if(GetTag(oInArea)=="ACR_SPAWN_WP"){
							SendMessageToPC(party_leader,"Debug: Found waypoint and disabling if creature!");
							if(GetLocalInt(oInArea,"ACR_SPAWN_TYPE")==0){
								SetLocalInt(oInArea,"ACR_SPAWN_IS_DISABLED",1);
							}
					}
					oInArea=GetNextObjectInArea(oHunting_area);
				}
			}
		}
	}
	ACR_TriggerOnClick();
}