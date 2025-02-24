// 1sc_search_destroyed
/*
	Description:
	When a chest is destroyed fake botoms and false walls
	suddenly don't matter anymore and all items in the
	chest are easely revealed.
	
	However damaging a chest with a weapon or magic will
	have a chance of damaging the items within the chest.
*/
// By System_Crush
// 27-7-07
#include "phat_searchable"
#include "phat_searchable_treasure"
void main()
	{
	// Do a search check that finds all items in the
	// chest, and place them in the chest so they will
	// drop on the floor.
	SearchChest(45);
	if(GetTag(OBJECT_SELF) == "dotr_sarcophagus")
		{CreateObject(OBJECT_TYPE_CREATURE, "003_cr_ud_mummy", GetLocation(OBJECT_SELF));
		}
	}