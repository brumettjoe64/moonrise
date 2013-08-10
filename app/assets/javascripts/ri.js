var global_ri_icon_loaded_color = "blue";
var global_ri_icon_unloaded_color = "#7D6E8B";

function ri_hover(x) {
  ri_unload(global_ri_poi);
  ri_load(x);
}

function ri_unhover(x) {
  ri_unload(x);
  ri_load(global_ri_poi);
}

function ri_save(x) {
  global_ri_poi = x;  
}

function ri_unload(x) {
  var icon = document.getElementById(x);
  icon.style.color = global_ri_icon_unloaded_color;
}

function ri_load(x) {
  // x is a string starting with "ri_poi_"
  var title = document.getElementById("ri_content_title");
  var img = document.getElementById("ri_content_img");
  var content = document.getElementById("ri_content");
  var icon = document.getElementById(x);

  var title_str = "";
  var img_str = "";
  var content_str = "";

  switch(x) {
    case "ri_poi_minkmeadow":
      title_str = "Mink Meadow";
      img_str = "/assets/ri-minkmeadow.jpg";
      content_str = "Jones family residence and the location of the ceremony and reception on July 5th.";
      break;
    case "ri_poi_narragansett":
      title_str = "Narragansett";
      img_str = "/assets/ri-narragansett.jpg";
      content_str = "With four of the state's most popular beaches, Narragansett is our recommended location to stay in Southern Rhode Island. Once a wealthy community rivaling nearby Newport, the history of Narragansett is still visible. The Towers, spanning Ocean Drive, is the only remaining section of a luxurious casino built in 1883. Having survived numerous fires and vicious nor'easters, The Towers is the town's most enduring landmark. Don't miss: Iggy's Clamcakes and Chowder.";
      break;
    case "ri_poi_fireworks":
      title_str = "Fireworks";
      img_str = "/assets/ri-fireworks.jpg";
      content_str = "Watch the local fireworks on Old Mountain Field, just down the street from Lauren's old high school and the quaint Main Street of her home town.  Pre-fireworks festivities include live music,children’s activities including three bounce houses and food vendors.  Don't miss: Del's Lemonade.";
      break;
    case "ri_poi_airport":
      title_str = "TF Green Airport (PVD)";
      img_str = "/assets/ri-airport.jpg";
      content_str = "TF Green is a quick 30 minute drive from Wakefield.  Boston Logan is not much farther, at only an hour and a half drive.";
      break;
    case "ri_poi_newport":
      title_str = "Newport";
      img_str = "/assets/ri-newport.jpg";
      content_str = "Once the summer playground of America's wealthiest families, Newport remains a popular summer vacation destination. The famous mansions offer detailed tours and give a fascinating glimpse into Gilded Age extravagance. While the town emphasizes its history with a variety of museums and tours, Newport also has a vibrant, contemporary side, made manifest in quirky shops and great restaurants.  Don't miss: Cliff walk.";
      break;
    case "ri_poi_providence":
      title_str = "Providence";
      img_str = "/assets/ri-providence.jpg";
      content_str = "The former rum and molasses trading town is now one of the best places to live in the United States. Historic sites, wonderful museums and theaters seamlessly blend with newer attractions on the block including a modern mega-mall, scenic Riverwalk, outdoor skating arena, convention center, plus new hotels and restaurants. Wander back in time on Benefit Street, where eminent Federal period homes recall the city's wealthy past. For a modern experience, check out the more than 100 stores at Providence Place. Or tantalize your taste buds on 'The Hill', a historic area that boasts many award- winning restaurants, from the Italian and Mediterranean, to Caribbean, Mexican, Chinese, seafood and baked goods. For a different perspective, take a romantic river cruise on an authentic Venetian gondola. Don't Miss: Waterfire.";
      break;
    case "ri_poi_blockisland":
      title_str = "Block Island";
      img_str = "/assets/ri-blockisland.jpg";
      content_str = "Sail away on the Block Island Ferry, and view the island's alluring blend of so many elements that help a frazzled refugee from the working world exhale and relax.  This pork chop-shaped island has gorgeous beaches, stunning ocean vistas, 32 miles of hiking trails, 250-foot-high coastal cliffs, a deep sense of history, and a lively night scene.  Don't Miss: Standing on the top deck of the Ferry.";
      break;
    case "ri_poi_galilee":
      title_str = "Port of Galilee";
      img_str = "/assets/ri-galilee.jpg";
      content_str = "A beautiful and authentic New England fishing, Galilee is known for its beautiful beaches, sightseeing cruises/tours, quality shopping, dining and unprecedented fishing/quahogging. It also is home to the Block Island Ferry. Galilee obtained it’s biblical title in 1902 from a Nova Scotia native fishermen Thomas Mann in spite of its prospering fishing economy. Ever since, Galilee has been a thriving fishing port that transports 16+ million pounds of fish/shellfish each year up and down the East Coast. It wasn’t until the 1930’s that the State of Rhode Island dredged the basin and built wharves providing a harbor and refuge for now what is the Port of Galilee and Point Judith Harbor of Refuge. Don't miss: Buying Lobsters at the Kristen J.";
      break;
    case "ri_poi_wickford":
      title_str = "Wickford";
      img_str = "/assets/ri-wickford.jpg";
      content_str = "Nestled along the waterfront of Wickford Harbor, historic Wickford Village offers a taste of New England as it was a century or more ago. Its historic homes from the 1700s, churches, gardens and picturesque harbor offer a glimpse of our nation’s early history.  Wickford is a thriving commercial village with a wonderful sense of history. Watch the boats, enjoy lunch at an outdoor cafe, browse through the shops, walk the tree-lined streets and even feed the ducks.  Don't Miss: Shopping for souveneirs";
      break;
    case "ri_poi_ny":
      title_str = "New York";
      img_str = "/assets/ri-ny.jpg";
      content_str = "A four hour drive or train ride will bring you to the big apple.  Conquering New York in one visit is impossible. Instead, hit the must-sees – the Empire State Building, the Statue of Liberty, Central Park, the Metropolitan Museum of Art – and then explore off the beaten path with visits to The Cloisters or one of the city’s libraries. Indulge in the bohemian shops of the West Village or the fine dining of the Upper West Side. The bustling marketplace inside of Grand Central Station gives you a literal taste of the best the city has to offer. Don't Miss: Real NY Bagels and Pizza.";
      break;
    case "ri_poi_boston":
      title_str = "Boston";
      img_str = "/assets/ri-boston.jpg";
      content_str = "A two hour drive and you can enjoy some of the country’s most important historical sites and impassioned sports fans. Catch a game at Fenway Park before heading to the North End for some of the Italian neighborhood’s legendary cannoli. Take in the gilded glory of the State House from the edge of the Boston Common, also the starting point for the Freedom Trail, a walking route between 16 sites that were integral to the American Revolution.  Don't Miss: Mike's Pastries in the North End.";
      break;
    case "ri_poi_capecod":
      title_str = "Cape Cod";
      img_str = "/assets/ri-capecod.jpg";
      content_str = "Quaint harbors, windswept beaches, glorious dunes and blinking lighthouses. Explore Cape Cod National Seashore, bike past cranberry bogs on the Rail Trail or saunter around Sandwich, the Cape's oldest town. Many areas are architectural and culinary gems - full of weathered shingles, whaling captains' mansions, chowder shacks and upscale dining delights. Don't miss Woods Hole Oceanquest, famed Martha's Vineyard or charmingly upbeat Provincetown.  Don't Miss: The beaches.";
      break;
    default:
      title_str = "";
      img_str = "/assets/image-blank.png";
      content_str = "";
      break;
  }

  title.innerHTML=title_str;
  img.src = img_str;
  content.innerHTML = content_str;
  icon.style.color = global_ri_icon_loaded_color;
}
