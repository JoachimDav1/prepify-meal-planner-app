# Prepify
***Prepify is the project I worked on with a team of three other Le Wagon Students at the end of our bootcamp.***
***The website was intended to be used on mobile but one of the areas of improvements will be to be displayable nicely on web as well..***
***The following sections will cover the different areas on which I personnaly worked and challenges encountered and future changes..***

## About the project itself :

Prepify is a meal planning application which intends to propose a large selection of recipes from which the user can plan their future meals. 
These planned meals were then displayed in their calendar section.
By selecting a range of dates in the Grocery list section, the user was then able to generate a grocery list based on the different ingredients included in the recipes planned during the selected period. 
The ingredients were then grouped by aisle section in which they can typically be found in most supermarkets.

## DataBase : 

The first challenge we encountered was related to the initial database of recipes. The team decided to use the [Spoonacular API](https://spoonacular.com/food-api). 
For each recipe the API proposed a large list of information such as: ingredients, instructions, score, cooking time... 
The main drawback was that by using their free plan, we were only allowed a limited number of request. 
In order for the team to work with similar recipes and not have to remake API calls, it was decided to implement an import-export tool.
The export part was done as a rake task which exported the three different models (Recipe, Ingredient, and RecipeIngredient) to excel. 
The import part was done using the [Roo rails gem](https://rubygems.org/gems/roo/versions/2.10.0), which allowed to go through each page of the excel file.
The most challenging aspect was recreating the initial associations. 

## Controllers : 

Rails applications work with the Model-View-Controller framework, with the controller containing the logic behind the information displayed on different pages.
During this project, I mainly worked on the Planned meals and Grocery list controller. 

#### Planned meals : 

The planned meal logic was pretty straightforward, as it was made of an index, create and destroy method. 
The create method used a date, a recipe and a user. For the date, we used [Flatpickr](https://flatpickr.js.org/), in the creation form, we included the recipe it was coming from and the user was simply the current one.

#### Grocery List: 

The grocery list was a little bit trickier. It only consisted of an update and index page. The team decided to only allow users to have one single grocery list, reason why there only is an udpate method.
For this grocery list, we allowed the user to select a range of dates, the user wanted to go grocery shopping for. In the params section, we had to grom from : "01/01/2024 to 02/01/2024", to two separate dates. This was done using the gsub function to select the parts individually.
Based on this two dates, we _populated_ the user grocery list with the ingredients that were included in the different recipes of those planned meals. 
If the current user did not have a grocery list, the index method included the empty shell for its creation. 
The grocery list also included a total amount for each ingredient. This total amount was the trickiest part of the process. 
First we needed to know if the ingredient was already included in the grocery list. If it was not, the total amount was set to the quantity referenced in the recipe. If it was, the amounts were summed together. 
_Working with an API, meant that we had no control on the information we were given. This means that in each recipe, the quantities might not be referenced in the same units every time. To tackle this issue, we aimed to standardize as much as possible the units during the seeding process. Tablespoon and teaspoon were for example transformed into ml.._
With this updated grocery list, we then grouped these ingredients depending on the aisle referenced in the ingredient model: this led to the declaration of the Aisle Hash. Which was the basis for the main information displayed in the view. 


## Forms' interactivity :

To enhance the interactivity of our different forms, we decided to _ajaxify_ their submition process.  This was the case for the "add to favorites" and "add to calendar" forms. Two forms included in many different pages. This meant creating a form partial and fetch request with a Patch or Post request.
Then for successful request, we either updated the the inital button or displayed a [sweet aler](https://sweetalert2.github.io/#frameworks-integrations) toast. _There was also an ajaxification of the checkbox in the grocery list._

## Future work and rework: 

There are multiple aspects of what was achieved which I would like to rework or create. 
Here is first list :
- #### Exports to JSON instead of EXCEL:
    By importing to JSON, the re-association of ingredients, recipe and recipe ingredients could be done easier. As of now, we had to include a Recipe Title and ingredient       name, instead of using the previous ID. Something which our initial intention.
  
- #### Allowing more page without an account :
    As of now, the only page available without an account is the home page. In order to search for a recipe's details or search for a recipe by name, you need to be              registred on the website which might be frustrating.
 
- #### Clickable banner:
  On most pages, the banner was  the first thing the user saw and was taking a significant mount of spaces while not being clickable. Something that could once again be        frustating, specifically for mobile user who are used to click everywhere.. 
  
-  #### The CSS and html is sometimes (leo) messy..
  
-  #### Web display as mentioned earlier..
   
-  #### Rework of the Grocery List :

  ###### The grocery list needs a rework in multiple aspects.
    1. It is messy and hard to read for anybody who did not code it (everybody but me lol).
    2. The checkbox are linked to a _bought_ boolean variable for the grocery list items. But do not            serve any other role than turning it to true. Including a probable price would be beneficial.
    3.  Some units are still weird (1 large, 5 medium is not very quantifiable imo)..
    4.  Inclusion of float quantities (some quantities are rounded up instead of being floats).


This concludes my personnal take on this two week end of bootcamp projects which I hope to push a little further in the near future !  


