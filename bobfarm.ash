


void fill_organs()
	{
	/*	Uses the specified consumption script to fill your organs
		If the relevant option is set to true eats a fortune cookie if you have no active fortune 
		cookie counter, and intelligently determines how much room to leave for cookies later in the
		day (this information is passed on to EatDrink.ash, but not to any other consumption scripts */
	announce(1, "Filling organs");
	announce(2, "fill_organs");
	if(CONSUME_SCRIPT == "")
		failure("No consumption script was specified");
	
	if(my_fullness() < fullness_limit() || my_inebriety() < inebriety_limit() || my_spleen_use() < spleen_limit())
		{
		announce(3, "Fullness: "+ my_fullness()); ###
		
		// Eat a cookie if no current counters and if doing SRs
		if(DOSEMIRARES && my_fullness() < fullness_limit())
			{
			cookie_room = num_srs();
	
			// If you don't have an active SR counter eat a cookie
			if(!sr_counter_active())
				{
				retrieve_item(1, $item[fortune cookie]);
				eatsilent(1, $item[fortune cookie]);
				
				cookie_room = max(0, cookie_room-1); // Avoid getting a negative number
				}
			}
		
		// Get ode if necessary
		if(have_effect($effect[ode to booze]) < (inebriety_limit() - my_inebriety()))
			{
			// Make room
			if(head_full())
				if(!equip_song_raisers())
					cli_execute("shrug "+ cheapest_at_buff().to_string());
			
			if(!have_skill($skill[the ode to booze]))
				request_buff($effect[ode to booze], inebriety_limit());
			}
		
		announce(3, "Cookie_room is currently "+ cookie_room);
		
		if(CONSUME_SCRIPT == "eatdrink.ash")
			eatdrink(fullness_limit()-cookie_room, inebriety_limit(), spleen_limit(), false);
		else
			cli_execute("run "+ CONSUME_SCRIPT);
		
		if(my_fullness() < fullness_limit()-cookie_room || my_inebriety() < inebriety_limit() || my_spleen_use() < spleen_limit())
			failure(CONSUME_SCRIPT +" failed to fill your organs completely");	
			
		if(have_effect($effect[ode to booze]) > 0)	
			cli_execute("shrug ode to booze");
		}
	else
		announce(3, "Your organs are already full");
	}
