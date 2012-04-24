script "BobFarm.ash";
//notify ShaBob;
import <EatDrink.ash>;
import <OCD Inventory Control.ash>;


string CONSUME_SCRIPT = vars["bobFarm_consume_script"];
int VERBOSITY = vars["bobFarm_verbosity"].to_int();


void announce(int verbosity_level, string message, boolean header)
	{
	/*	Prints <message> if the user's verbosity setting is greater than or equal to 
		<verbosity_level>. 
		Red = error, blue = normal info, purple = function name, olive = internal function info.
		If the optional parameter <header> is true prints a line across the mafia gCLI under the
		message. */
	string colour;
	switch (verbosity_level)
		{
		case -1:
			colour = "red";
			break;
		case 1:
			colour = "blue";
			break;
		case 2:
			colour = "purple";
			break;
		case 3:
			colour = "olive";
			break;
		}
	
	if(verbosity_level <=  VERBOSITY)
		{
		if(header)
			print("");
		print(message, colour);
		if(header)	
			print_html("<hr>");
		}
	}
	
void announce(int verbosity_level, string message)
	{
	/* Overloader for the three parameter version */
	announce(verbosity_level, message, false);
	}

void failure(string message)
	{
	abort(message);
	}


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
		
		// Get ode if necessary
		if(have_effect($effect[ode to booze]) < (inebriety_limit() - my_inebriety()))
			{
			if(!have_skill($skill[the ode to booze]))
				request_buff($effect[ode to booze], inebriety_limit());
			}
		
		if(CONSUME_SCRIPT == "EatDrink.ash")
			eatdrink(fullness_limit(), inebriety_limit(), spleen_limit(), false);
		else
			cli_execute("run "+ CONSUME_SCRIPT);
		
		if(my_fullness() < fullness_limit() || my_inebriety() < inebriety_limit() || my_spleen_use() < spleen_limit())
			failure(CONSUME_SCRIPT +" failed to fill your organs completely");	
			
		if(have_effect($effect[ode to booze]) > 0)	
			cli_execute("shrug ode to booze");
		}
	else
		announce(3, "Your organs are already full");
	}

