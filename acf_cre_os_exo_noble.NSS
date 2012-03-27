////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_CreatureOnSpawnIn();
	
	
	//create one of the two types of fist chain armour, and one of three of the relevant types of helmet
	//an equip them to the NPC
	int D2a=d2(1);
	int D2b=d2(1);
	int D20a=d20(1);
    int D20b=d10(1);
	int D40=d100(1);
	do
	{D40=d100(1);}
	while(D40>40);
	
	string sArmType;
	string sHelmType;
	string sCapeType;
	switch (D20a)
		{
		case 1:sArmType="lem_clothing_f2_01";break;
		case 2:sArmType="lem_clothing_f2_02";break;
		case 3:sArmType="lem_clothing_f2_03";break;
		case 4:sArmType="lem_clothing_f2_04";break;
		case 5:sArmType="lem_clothing_f2_05";break;
		case 6:sArmType="lem_clothing_b1_01";break;
		case 7:sArmType="lem_clothing_b1_02";break;
		case 8:sArmType="lem_clothing_b1_03";break;
		case 9:sArmType="lem_clothing_b1_04";break;
		case 10:sArmType="lem_clothing_b1_05";break;
		case 11:sArmType="lem_clothing_b2f_01";break;
		case 12:sArmType="lem_clothing_b2f_02";break;
		case 13:sArmType="lem_clothing_b2f_03";break;
		case 14:sArmType="lem_clothing_b2f_04";break;
		case 15:sArmType="lem_clothing_b2f_05";break;
		case 16:sArmType="lem_clothing_b2s_01";break;
		case 17:sArmType="lem_clothing_b2s_02";break;
		case 18:sArmType="lem_clothing_b2s_03";break;
		case 19:sArmType="lem_clothing_b2s_04";break;
		case 20:sArmType="lem_clothing_b2s_05";break;
		}
	switch (D40)
		{
		case 1:sHelmType="lem_turban_e_01";break;
		case 2:sHelmType="lem_turban_e_02";break;
		case 3:sHelmType="lem_turban_e_03";break;
		case 4:sHelmType="lem_turban_e_04";break;
		case 5:sHelmType="lem_turban_e_05";break;
		case 6:sHelmType="lem_turban_e_06";break;
		case 7:sHelmType="lem_turban_e_07";break;
		case 8:sHelmType="lem_turban_e_08";break;
		case 9:sHelmType="lem_turban_e_09";break;
		case 10:sHelmType="lem_turban_e_10";break;
		case 11:sHelmType="lem_turban_fl_01";break;
		case 12:sHelmType="lem_turban_fl_02";break;
		case 13:sHelmType="lem_turban_fl_03";break;
		case 14:sHelmType="lem_turban_fl_04";break;
		case 15:sHelmType="lem_turban_fl_05";break;
		case 16:sHelmType="lem_turban_fl_06";break;
		case 17:sHelmType="lem_turban_fl_07";break;
		case 18:sHelmType="lem_turban_fl_08";break;
		case 19:sHelmType="lem_turban_fl_09";break;
		case 20:sHelmType="lem_turban_fl_10";break;
		case 21:sHelmType="lem_turban_el_01";break;
		case 22:sHelmType="lem_turban_el_02";break;
		case 23:sHelmType="lem_turban_el_03";break;
		case 24:sHelmType="lem_turban_el_04";break;
		case 25:sHelmType="lem_turban_el_05";break;
		case 26:sHelmType="lem_turban_el_06";break;
		case 27:sHelmType="lem_turban_el_07";break;
		case 28:sHelmType="lem_turban_el_08";break;
		case 29:sHelmType="lem_turban_el_09";break;
		case 30:sHelmType="lem_turban_el_10";break;
		case 31:sHelmType="lem_turban_f_01";break;
		case 32:sHelmType="lem_turban_f_02";break;
		case 33:sHelmType="lem_turban_f_03";break;
		case 34:sHelmType="lem_turban_f_04";break;
		case 35:sHelmType="lem_turban_f_05";break;
		case 36:sHelmType="lem_turban_f_06";break;
		case 37:sHelmType="lem_turban_f_07";break;
		case 38:sHelmType="lem_turban_f_08";break;
		case 39:sHelmType="lem_turban_f_09";break;
		case 40:sHelmType="lem_turban_f_10";break;

		}
	switch (D20b)
		{
		case 1:sCapeType="lem_clothing_cpe_01";break;
		case 2:sCapeType="lem_clothing_cpe_02";break;
		case 3:sCapeType="lem_clothing_cpe_03";break;
		case 4:sCapeType="lem_clothing_cpe_04";break;
		case 5:sCapeType="lem_clothing_cpe_05";break;
		case 6:sCapeType="lem_clothing_cpe_06";break;
		case 7:sCapeType="lem_clothing_cpe_07";break;
		case 8:sCapeType="lem_clothing_cpe_08";break;
		case 9:sCapeType="lem_clothing_cpe_09";break;
		case 10:sCapeType="lem_clothing_cpe_10";break;
		case 11:sCapeType="lem_clothing_cpf_01";break;
		case 12:sCapeType="lem_clothing_cpf_02";break;
		case 13:sCapeType="lem_clothing_cpf_03";break;
		case 14:sCapeType="lem_clothing_cpf_04";break;
		case 15:sCapeType="lem_clothing_cpf_05";break;
		case 16:sCapeType="lem_clothing_cpf_06";break;
		case 17:sCapeType="lem_clothing_cpf_07";break;
		case 18:sCapeType="lem_clothing_cpf_08";break;
		case 19:sCapeType="lem_clothing_cpf_09";break;
		case 20:sCapeType="lem_clothing_cpf_10";break;
		}
	object oArmour=CreateItemOnObject(sArmType);
	object oHelmet=CreateItemOnObject(sHelmType);
	object oCape=CreateItemOnObject(sCapeType);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oArmour,1));
	if(D2a==1){AssignCommand(OBJECT_SELF,ActionEquipItem(oHelmet,0));}
	if(D2b==1){AssignCommand(OBJECT_SELF,ActionEquipItem(oCape,6));}
	

    // Custom code goes here.
			object oDM = OBJECT_SELF;
	        object oFlocker = GetLocalObject(oDM, "Object_Target");
			int iRadius;
			int iArea;
			if(oFlocker != OBJECT_INVALID)
				{SetLocalInt(oFlocker, "ACR_FLOCKING", 1);
				 iRadius = GetLocalInt(oDM, "iRadiusFlocking");
				 iArea = GetLocalInt(oDM, "iAreaFlocking");
				 }
	        if(oFlocker == OBJECT_INVALID)
				{oFlocker = OBJECT_SELF;
				}		
				 
	
	
	if(GetLocalInt(oFlocker, "ACR_FLOCKING") == 1) 
		{object oMobDestination = GetNearestObject(OBJECT_TYPE_ALL, oFlocker, 1);
		 string sArea = GetName(GetArea(oFlocker));
		 //Set the flocking destinations and execute the flocking script	
		 int iRep = 1;
		 object oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
		 if((FindSubString(GetName(oRandom1), "Sky") != -1) || (FindSubString(GetName(oRandom1), "Walkmesh") != -1))
				{oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
				}
		 object oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
		 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
				{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
		    	}
		 if(oRandom2 == oRandom1)
				{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
				 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
						{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
				    	}
				}
		 object oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
		 if((FindSubString(GetName(oRandom3), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
				{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
				}
		 if((oRandom3 == oRandom1) || (oRandom3 == oRandom2))
				{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
				 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
						{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
			   			}
				}
			object oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
			if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
				{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
			   	}
			if((oRandom4 == oRandom1)  || (oRandom4 == oRandom2)|| (oRandom4 == oRandom3))
				{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
				if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
					{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
				   	}
				}
			object oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
			if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
				{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
			   	}
			if((oRandom5 == oRandom1) || (oRandom5 == oRandom4)|| (oRandom5 == oRandom3)|| (oRandom5 == oRandom2))
					{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
						{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
			    		}
					}
			object oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
			if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
					{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
			    	}
			if((oRandom6 == oRandom1) || (oRandom6 == oRandom5) || (oRandom6 == oRandom4)|| (oRandom6 == oRandom3)|| (oRandom6 == oRandom2))
					{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
					if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
						{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
				    	}
					}
			if(oRandom1 == OBJECT_INVALID)
					{oRandom1 = oMobDestination;
					}
			if(oRandom2 == OBJECT_INVALID)
					{oRandom2 = oMobDestination;
						}
			if(oRandom3 == OBJECT_INVALID)
					{oRandom3 = oMobDestination;
					}
			if(oRandom4 == OBJECT_INVALID)
					{oRandom4 = oMobDestination;
					}
			if(oRandom5 == OBJECT_INVALID)
					{oRandom5 = oMobDestination;
					}
			if(oRandom6 == OBJECT_INVALID)
					{oRandom6 = oMobDestination;
					}
						
						
			SendMessageToPC(oDM, GetName(oFlocker) + " flocking");
			SetLocalObject(oFlocker, "oRandom1", oRandom1);
			SetLocalObject(oFlocker, "oRandom2", oRandom2);
			SetLocalObject(oFlocker, "oRandom3", oRandom3);
			SetLocalObject(oFlocker, "oRandom4", oRandom4);
			SetLocalObject(oFlocker, "oRandom5", oRandom5);
			SetLocalObject(oFlocker, "oRandom6", oRandom6);
			SetLocalInt(oFlocker, "Flocked", 1);
			SetLocalInt(oFlocker, "ACR_FLOCKING", 1);
			DelayCommand(5.0, ExecuteScript("acf_cre_flocking", oFlocker));
						 
			object oChild = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE); 
		    if(iRadius != 0)
				{while(oChild != OBJECT_INVALID) 
					{if((GetIsPC(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") != 1))
						{SendMessageToPC(oDM, GetName(oChild) + " flocking");
						 SetLocalObject(oChild, "oRandom1", oRandom1);
						 SetLocalObject(oChild, "oRandom2", oRandom2);
						 SetLocalObject(oChild, "oRandom3", oRandom3);
						 SetLocalObject(oChild, "oRandom4", oRandom4);
						 SetLocalObject(oChild, "oRandom5", oRandom5);
						 SetLocalObject(oChild, "oRandom6", oRandom6);
						 SetLocalInt(oChild, "Flocked", 1);
						 SetLocalInt(oChild, "ACR_FLOCKING", 1);
				 		 DelayCommand(5.0, ExecuteScript("acf_cre_flocking", oChild));
						 }
					 oChild = GetNextObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE);
					}
					
					SetLocalInt(oDM, "iRadiusFlocking", 0);
				}
				if(iArea != 0)
								{object oChild = GetFirstObjectInArea(GetArea(oFlocker)); 
		 						 while(oChild != OBJECT_INVALID) 
									{if((GetObjectType(oChild) == OBJECT_TYPE_CREATURE) && (GetIsPC(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") == 0))
										{SendMessageToPC(oDM, GetName(oChild) + " flocking");
						 				 oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
										 if((FindSubString(GetName(oRandom1), "Sky") != -1) || (FindSubString(GetName(oRandom1), "Walkmesh") != -1))
												{oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												}
										  oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
										 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
												{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
										    	}
										 if(oRandom2 == oRandom1)
												{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
												 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
														{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												    	}
												}
										  oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
										 if((FindSubString(GetName(oRandom3), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
												{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												}
										 if((oRandom3 == oRandom1) || (oRandom3 == oRandom2))
												{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
												 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
														{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											   			}
												}
											 oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
											if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
												{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											   	}
											if((oRandom4 == oRandom1)  || (oRandom4 == oRandom2)|| (oRandom4 == oRandom3))
												{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
												if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
													{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												   	}
												}
											 oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
											if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
												{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											   	}
											if((oRandom5 == oRandom1) || (oRandom5 == oRandom4)|| (oRandom5 == oRandom3)|| (oRandom5 == oRandom2))
													{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
													if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
														{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											    		}
													}
											 oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
											if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
													{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											    	}
											if((oRandom6 == oRandom1) || (oRandom6 == oRandom5) || (oRandom6 == oRandom4)|| (oRandom6 == oRandom3)|| (oRandom6 == oRandom2))
													{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
													if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
														{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												    	}
													}
											
											 SetLocalObject(oChild, "oRandom1", oRandom1);
											 SetLocalObject(oChild, "oRandom2", oRandom2);
											 SetLocalObject(oChild, "oRandom3", oRandom3);
											 SetLocalObject(oChild, "oRandom4", oRandom4);
											 SetLocalObject(oChild, "oRandom5", oRandom5);
											 SetLocalObject(oChild, "oRandom6", oRandom6);
											 SetLocalInt(oChild, "Flocked", 1);
										 	 SetLocalInt(oChild, "ACR_FLOCKING", 1);
				 		 					 DelayCommand(5.0, ExecuteScript("acf_cre_flocking", oChild));
										 	}
								 	oChild = GetNextObjectInArea(GetArea(oFlocker));
									}
								 SetLocalInt(oDM, "iAreaFlocking", 0);
								  }
							}			 

}