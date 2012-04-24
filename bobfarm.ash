script "BobFarm.ash";
//notify ShaBob;
import <EatDrink.ash>;

void endSale()
	{
	foreach foo  in $items[	Angry Farmer Candy, 
				awful poetry journal, 
				chaos butterfly, 
				disturbing fanfic, 
				furry fur, 
				giant needle, 
				heavy d, 
				Mick's IcyVapoHotness Rub, 
				original g, 
				plot hole, 
				probability potion, 
				procrastination potion, 
				rave whistle, 
				wolf mask, 
				] 
		{
		if (item_amount(foo) > 0)
			{
			print_html("Autoselling " + item_amount(foo) + " " + foo);
			autosell(item_amount(foo), foo);
			}
		}
	if (item_amount($item[thin black candle]) > 3)
		{
		int haveCandles = item_amount($item[thin black candle]);
		print_html("You have " + haveCandles + " Thin Black Candles");
		print_html("Autoselling " + (item_amount($item[thin black candle])-3).to_int() + " Thin Black Candle");
		autosell((item_amount($item[thin black candle])-3), $item[thin black candle]);
		}
	}



void main()
	{
	print_html("<b>Starting by Calling EatDrink.ash.</b>");
//	eatdrink ( fullness_limit(), inebriety_limit(), spleen_limit(), FALSE );//use up any remaining diet room
	print_html("Putting on the Meat Gear.");
//	maximize ("meat", false );
	print_html("Going out to fight the good fight.");
//	adventure(my_adventures(), $location[giant's castle] );
	print_html("Right. Farming complete, now to market, to market.");
	endSale();
	print_html("<b>Calling EatDrink for your rollover pleasure.</b>");	
//	eatdrink ( fullness_limit(), inebriety_limit(), spleen_limit(), TRUE );//use up any remaining diet room	
	}
	
