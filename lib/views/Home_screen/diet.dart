// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/common_widgets/radioButton.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/consts/strings.dart';
import 'package:untitled/model/user_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common_widgets/boxWidget.dart';
import '../../consts/images.dart';
import '../../consts/styles.dart'; // Importing images file again (redundant)

// Define a Diet class which is a StatelessWidget
class Diet extends StatefulWidget {
  const Diet({super.key});

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {
  // Constructor
  bool _isVisible = false;
  bool isLoading = true;

  List<AddUserModel> user = [];
  Future<void> getUser() async {
    try {
      // Clear the user list and update the UI
      user.clear();

      // Open the SQLite database
      Database database = await openDatabase(
        join(await getDatabasesPath(), 'your_database.db'),
        version: 1,
      );

      // Query the database to retrieve the user profile
      List<Map<String, dynamic>> userRows = await database.query(
        'users',
        where: 'doc = ?',
        whereArgs: [StaticInfo.docId.toString()],
      );

      // Process the retrieved user data
      for (int i = 0; i < userRows.length; i++) {
        AddUserModel dataModel = AddUserModel.fromJson(userRows[i]);
        user.add(dataModel);
      }

      // Close the database
      await database.close();

      // Calculate total calories
      setState(() {
        isLoading = false;


      });

      // Print the name of the user
      if (user.isNotEmpty) {
        print('Name: ${user[0].name}');
      }
    } catch (e) {
      // Handle any errors
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  final List dietList = [
    lowCrab,
    highProtein,
    ketoDiet,
    veg,
  ];
  String? _selectedOption;

  final List<DietModel> loseWeightDataOne = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\nScrambled Eggs with Spinach and Avocado\n\n2 large eggs, scrambled\n1 cup fresh spinach, sautéed in olive oil\n1/4 avocado, slicedSalt and pepper to taste\n\n',
      image: 'assets/images/loseWeight/Breakfastl.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\nGrilled Chicken Salad\n\n4 oz grilled chicken breast, sliced\n2 cups mixed greens (spinach, lettuce, arugula, etc.)\n1/4 cucumber, sliced\n1/4 bell pepper, sliced\n1/4 cup cherry tomatoes, halved\n2 tbsp olive oil and balsamic vinegar dressing (or dressing of choice)\nOptional: sprinkle of feta cheese or chopped nuts\n\n',
      image: 'assets/images/loseWeight/Lunchl.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\nBaked Salmon with Roasted Vegetables\n4 oz salmon fillet, seasoned with lemon juice, garlic, and herbs\n1 cup mixed vegetables (such as broccoli, cauliflower, and carrots), roasted with olive oil and spices\nSide salad with mixed greens, sliced radishes, and a vinaigrette dressing\nSnacks (optional):\n\n1/4 cup almonds or walnuts\n1/2 cup sliced cucumber with hummus\nGreek yogurt with berries (unsweetened)',
      image: 'assets/images/loseWeight/Dinnerl.jpeg',
    ),
  ];
  final List<DietModel> loseWeightDataTwo = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\nScrambled Tofu with Spinach\n200g firm tofu, crumbled\n1 cup fresh spinach leaves\n1/4 onion, diced\n1 clove garlic, minced\n1 tablespoon olive oil\nSalt and pepper to taste\n\n',
      image: 'assets/images/loseWeight/Breakfasth.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\n\nTurkey and Avocado Wrap\nIngredients:\n\n100g sliced turkey breast\n1 whole wheat or low-carb tortilla wrap\n1/4 avocado, mashed\n1/4 cup shredded lettuce\n1/4 cup sliced cucumber\n1 tablespoon Greek yogurt or light mayonnaise\n\n',
      image: 'assets/images/loseWeight/Lunchh.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\nQuinoa Stuffed Bell Peppers\n\nIngredients:\n\n2 large bell peppers (any color), halved and seeds removed\n1/2 cup quinoa, rinsed\n1 cup vegetable or chicken broth\n150g lean ground turkey or chicken\n1/4 onion, diced\n1 clove garlic, minced\n1/2 cup diced tomatoes (fresh or canned)\n1/4 cup grated low-fat cheese (such as mozzarella or cheddar)\n1 tablespoon olive oil\nSalt and pepper to taste',
      image: 'assets/images/loseWeight/Dinnerh.jpeg',
    ),
  ];
  final List<DietModel> loseWeightDataThree = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          'Keto Avocado and Turkey Bacon Omelette\n\nIngredients:\n\n2 large eggs\n2 slices of turkey bacon, cooked and chopped\n1/4 avocado, sliced\n1/4 cup shredded cheddar cheese\nSalt and pepper to taste\n1 tablespoon olive oil or butter for cooking\n\n',
      image: 'assets/images/loseWeight/Breakfastk.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          'Keto Zucchini Noodle Salad with Grilled Chicken\n\nIngredients:\n\n2 medium zucchinis, spiralized into noodles\n4 oz grilled chicken breast, sliced\n1/4 cup cherry tomatoes, halved\n1/4 cup sliced cucumber\n1/4 cup sliced red bell pepper\n2 tablespoons crumbled feta cheese\n2 tablespoons chopped fresh basil\n2 tablespoons olive oil\n1 tablespoon balsamic vinegar\nSalt and pepper to taste\n',
      image: 'assets/images/loseWeight/Lunchk.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          'Keto Cauliflower Fried Rice with Shrimp\n\nIngredients:\n\n1 small head cauliflower, grated or finely chopped\n8 oz shrimp, peeled and deveined\n2 cloves garlic, minced\n1/2 cup diced bell peppers (any color)\n1/4 cup diced carrots\n1/4 cup diced green onions\n2 eggs, beaten\n2 tablespoons soy sauce or tamari (for gluten-free option)\n1 tablespoon sesame oil\nSalt and pepper to taste',
      image: 'assets/images/loseWeight/Dinnerk.jpeg',
    ),
  ];
  final List<DietModel> loseWeightDataFour = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\nGreek Yogurt Parfait\n\n1 cup Greek yogurt (plain or flavored)\n1/2 cup mixed berries (such as strawberries, blueberries, raspberries)\n1/4 cup granola\n1 tablespoon honey or maple syrup (optional)\n\n',
      image: 'assets/images/loseWeight/Breakfastn.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\n\nQuinoa Salad with Chickpeas\n\n1 cup cooked quinoa\n1/2 cup canned chickpeas, rinsed and drained\n1/2 cucumber, diced\n1/2 bell pepper, diced\n1/4 red onion, finely chopped\n1/4 cup chopped fresh parsley\n2 tablespoons olive oil\n1 tablespoon lemon juice\nSalt and pepper to taste\n\n',
      image: 'assets/images/loseWeight/Lunchn.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\n\nTurkey and Vegetable Stir-Fry\n\n1 tablespoon olive oil\n8 oz (225g) lean ground turkey\n2 cups mixed vegetables (such as bell peppers, broccoli, snap peas, carrots)\n2 cloves garlic, minced\n2 tablespoons soy sauce\n1 tablespoon hoisin sauce\n1 teaspoon sesame oil\nCooked brown rice or quinoa for serving',
      image: 'assets/images/loseWeight/Dinnern.jpeg',
    ),
  ];

  final List<DietModel> gainWeightDataOne = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\n\nLow Carb Breakfast Burrito\n - Eggs\n- Bacon or sausage\n- Avocado\n- Cheese\n- Low-carb tortillas or lettuce wraps\n- Spinach or other leafy greens\n - Salsa or hot sauce (optional)\n\n',
      image: 'assets/images/gainWeight/Breakfastl.jpg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\n\nLow Carb Beef and Broccoli Stir-Fry\n\n- Beef (such as sirloin or flank steak)\n- Broccoli\n- Bell peppers\n - Onion\n - Garlic\n- Soy sauce (low-sodium)\n- Olive oil or sesame oil\n- Ginger\n- Cauliflower rice or shirataki noodles (optional)\n\n ',
      image: 'assets/images/gainWeight/Lunchl.jpg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\n\nLow Carb Creamy Garlic Parmesan Chicken\n\n- Chicken thighs or breasts\n- Heavy cream\n - Parmesan cheese\n- Garlic\n- Spinach or kale\n- Mushrooms\n- Olive oil or butter\n- Salt and pepper\n- Herbs (such as thyme or rosemary)',
      image: 'assets/images/gainWeight/Dinnerl.jpg',
    ),
  ];
  final List<DietModel> gainWeightDataTwo = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\nProtein-Packed Omelette\n\nIngredients:\n- 3 large eggs\n- 1/2 cup diced cooked ham\n- 1/4 cup shredded cheddar cheese\n- 1/4 cup diced bell peppers\n- 1/4 cup diced onions\n- 1 tablespoon olive oil\n\n',
      image: 'assets/images/gainWeight/Breakfasth.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\nQuinoa and Black Bean Bowl\n\nIngredients:\n- 1 cup cooked quinoa\n- 1/2 cup cooked black beans\n- 1/4 cup diced avocado\n- 1/4 cup diced tomatoes\n- 1/4 cup diced red onions\n- 1/4 cup chopped fresh cilantro\n- 1 tablespoon lime juice\n- Salt and pepper to taste\n\n',
      image: 'assets/images/gainWeight/Lunchh.jpg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\nBeef Stir-Fry with Brown Rice\n\nIngredients:\n- 6 oz beef sirloin, thinly sliced\n- 1 cup cooked brown rice\n- 1 cup mixed stir-fry vegetables (such as bell peppers, broccoli, and snap peas)\n- 2 cloves garlic, minced\n- 2 tablespoons soy sauce\n - 1 tablespoon olive oil\n - 1 teaspoon sesame oil\n - 1 teaspoon cornstarch (optional, for thickening the sauce)',
      image: 'assets/images/gainWeight/Dinnerh.jpg',
    ),
  ];
  final List<DietModel> gainWeightDataThree = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\n\nKeto Coconut Flour Pancakes with Berries and Whipped Cream\n\nIngredients:\n- 2 large eggs\n- 2 tablespoons coconut flour\n- 1 tablespoon unsweetened almond milk\n- 1/2 teaspoon baking powder\n- 1/4 teaspoon vanilla extract\n- 1 tablespoon erythritol or monk fruit sweetener (optional)\n- 1 tablespoon butter or coconut oil\n- 1/4 cup mixed berries (such as strawberries, blueberries, and raspberries)\n- 2 tablespoons heavy whipping cream (for whipped cream)\n\n',
      image: 'assets/images/gainWeight/Breakfastk.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\n\nKeto Beef and Broccoli Stir-Fry\n\nIngredients:\n\n6 ounces of beef sirloin, thinly sliced\n1 cup broccoli florets\n2 tablespoons soy sauce (or coconut aminos for a gluten-free option)\n 1 tablespoon olive oil\n 1 clove garlic, minced\n 1/2 teaspoon ginger, minced\n Salt and pepper to taste\n Optional: sesame seeds for garnish\n\n',
      image: 'assets/images/gainWeight/Lunchk.jpg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\n\nKeto Creamy Garlic Parmesan Salmon\n\n Ingredients:\n\n2 salmon fillets\n2 tablespoons butter\n2 cloves garlic, minced\n1/4 cup heavy cream\n1/4 cup grated Parmesan cheese\nSalt and pepper to taste\nFresh parsley for garnish (optional)',
      image: 'assets/images/gainWeight/Dinnerk.jpg',
    ),
  ];
  final List<DietModel> gainWeightDataFour = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\n \nScrambled Eggs with Avocado Toast:\n- 2 eggs\n- 1 avocado\n- 2 slices of whole grain bread\n- Butter or olive oil for cooking\n- Salt and pepper to taste\n\n',
      image: 'assets/images/gainWeight/Breakfastn.jpg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\nTurkey and Cheese Sandwich with Sweet Potato Fries\n- 2 slices of whole grain bread\n- 4 slices of turkey breast\n- 2 slices of cheese (your choice)\n- 1 medium sweet potato\n- Olive oil\n- Salt and pepper to taste\n\n',
      image: 'assets/images/gainWeight/Lunchn.jpg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\nBeef Stir-Fry with Rice\n- 200g beef strips\n- 1 cup mixed vegetables (bell peppers, broccoli, carrots)\n- 1 cup cooked rice\n- Soy sauce\n- Garlic powder\n- Ginger powder\n- Olive oil',
      image: 'assets/images/gainWeight/Dinnern.jpeg',
    ),
  ];

  final List<DietModel> maintainWeightDataOne = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\n\nLow Carb Veggie Omelette\n\nIngredients:\n- 2 eggs\n- 1/4 cup diced bell peppers\n- 1/4 cup diced onions\n- 1/4 cup sliced mushrooms\n- 1 tablespoon olive oil\n- Salt and pepper to taste\n- Optional: sprinkle of shredded cheese\n\n',
      image: 'assets/images/maintainWeight/Breakfastl.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\n\nTuna Lettuce Wraps\n\nIngredients:\n- 1 can of tuna in water, drained\n- 2 large lettuce leaves (such as romaine or iceberg)\n- 1/4 cup diced celery\n- 1/4 cup diced cucumber\n- 1 tablespoon mayonnaise (or Greek yogurt for a lower-fat option)\n- 1 teaspoon mustard\n- Salt and pepper to taste\n- Optional: sliced avocado\n\n',
      image: 'assets/images/maintainWeight/Lunchl.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\n\nZucchini Noodles with Pesto Sauce\n\nIngredients:\n- 2 medium zucchinis, spiralized into noodles\n- 2 tablespoons pesto sauce (look for low carb options or make your own)\n- 1 tablespoon olive oil\n- 2 tablespoons grated Parmesan cheese\n- Salt and pepper to taste\n- Optional: cherry tomatoes for garnish',
      image: 'assets/images/maintainWeight/Dinnerl.jpeg',
    ),
  ];
  final List<DietModel> maintainWeightDataTwo = [
    DietModel(
      title:
          'Sure, here\'s a meal plan for a person with a high-protein diet who wants to maintain weight:\n\nBreakfast:',
      detail:
          '\n\nScrambled Tofu with Spinach and Whole Wheat Toast**\n\nIngredients:\n- Firm tofu\n- Spinach\n- Onion\n- Bell pepper\n- Turmeric\n- Garlic powder\n- Salt and pepper\n- Whole wheat bread\n\n',
      image: 'assets/images/maintainWeight/Breakfasth.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\n\nQuinoa Salad with Chickpeas and Avocado**\n\nIngredients:\n- Cooked quinoa\n- Chickpeas\n- Cherry tomatoes\n- Cucumber\n- Red onion\n- Avocado\n- Fresh parsley\n- Lemon juice\n- Olive oil\n- Salt and pepper\n\n',
      image: 'assets/images/maintainWeight/Lunchh.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\n\nSalmon Fillet with Steamed Broccoli and Sweet Potato**\n\nIngredients:\n- Salmon fillet\n- Broccoli\n- Sweet potato\n- Olive oil\n- Garlic\n- Lemon\n- Paprika\n- Salt and pepper',
      image: 'assets/images/maintainWeight/Dinnerh.jpeg',
    ),
  ];
  final List<DietModel> maintainWeightDataThree = [
    DietModel(
      title:
          'Sure, here\'s a sample meal plan for a person following a ketogenic diet to maintain weight:\n\nBreakfast\n',
      detail:
          '\nKeto Avocado and Bacon Omelette\n\n- 2 eggs\n- 2 slices of bacon\n- 1/4 avocado\n- 1 tablespoon olive oil\n- Salt and pepper to taste\n\n',
      image: 'assets/images/maintainWeight/Breakfastk.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\nKeto Cobb Salad\n\n- 2 cups mixed salad greens\n- 2 hard-boiled eggs\n- 2 slices cooked bacon\n- 1/4 avocado\n- 1/4 cup cherry tomatoes\n- 2 tablespoons crumbled blue cheese\n- 2 tablespoons olive oil\n- 1 tablespoon balsamic vinegar\n- Salt and pepper to taste\n\n',
      image: 'assets/images/maintainWeight/Lunchk.webp',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\nKeto Salmon with Roasted Asparagus\n\n- 6 oz salmon fillet\n- 1 tablespoon olive oil\n- 1/2 teaspoon garlic powder\n- 1/2 teaspoon paprika\n- Salt and pepper to taste\n- 6 spears asparagus\n- 1 tablespoon grated Parmesan cheese\n- 1 tablespoon chopped fresh parsley',
      image: 'assets/images/maintainWeight/Dinnerk.jpeg',
    ),
  ];
  final List<DietModel> maintainWeightDataFour = [
    DietModel(
      title: 'Breakfast\n',
      detail:
          '\nScrambled Eggs with Spinach and Whole Wheat Toast\n\nEggs\nFresh spinach\nWhole wheat bread\nOlive oil or butter (for cooking)\nSalt and pepper\n\n',
      image: 'assets/images/maintainWeight/Breakfastn.jpeg',
    ),
    DietModel(
      title: 'Lunch\n',
      detail:
          '\nTurkey and Avocado Sandwich with Mixed Greens Salad\n\nSliced turkey breast\nAvocado\nWhole grain bread\nLettuce\nTomato\nCucumber\nRed onion\nOlive oil and vinegar (for dressing)\nSalt and pepper\n\n',
      image: 'assets/images/maintainWeight/Lunchn.jpeg',
    ),
    DietModel(
      title: 'Dinner\n',
      detail:
          '\nPasta Primavera with Grilled Shrimp\n\nWhole wheat pasta\nMixed vegetables (such as bell peppers, zucchini, carrots, broccoli)\nShrimp\nOlive oil\nGarlic\nParmesan cheese\nItalian seasoning\nSalt and pepper',
      image: 'assets/images/maintainWeight/Dinnern.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading?Center(child: CircularProgressIndicator()):
        ListView(
          children: [
            (context.screenHeight * 0.04).heightBox,
            // Widget to add vertical space
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      diet.text.size(25).fontFamily(bold).make(),
                      SizedBox(
                        width: 10,
                      ),
                      user[0].goals!.text
                              .size(15)
                              .fontFamily(semibold)
                              .make()
                    ],
                  ) // Widget to display text
                  ),
            ),
            (context.screenHeight * 0.02).heightBox,
            // Widget to add vertical space
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                    dietList.length,
                    (index) => StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Column(
                              children: [
                                // Widget to display a BoxWidget with a title and icon
                                BoxWidget(
                                  title: dietList[index].toString(),
                                  icon: (icArrow),
                                  width: (context.screenWidth - 40),
                                  onTap: () {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                    });
                                  },
                                  onTapText: () {
                                    setState(() {
                                      _isVisible = false;
                                    });
                                    showMenu(
                                      color: Colors.white,
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          15,
                                          index == 0 ? MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.23
                                              : index == 1
                                                  ? MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.33
                                                  : index == 2
                                                      ? MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.43
                                                      : MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.53,
                                          0,
                                          10),
                                      items: <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'option1',
                                          child: Text('Breakfast'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'option2',
                                          child: Text('Lunch'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'option3',
                                          child: Text('Dinner'),
                                        ),
                                      ],
                                      elevation: 8.0,
                                    ).then((value) {
                                      if (value != null) {
                                        print('Selected option: $value');
                                      }
                                    });
                                  },
                                  requireWidget: Visibility(
                                      visible: _isVisible,
                                      child:
                                          index == 0 && user[0].goals == "Lose Weight"
                                              ? Column(
                                                  children: List.generate(
                                                    loseWeightDataOne.length,
                                                    (index) => Row(
                                                      children: [
                                                        Expanded(
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text: loseWeightDataOne[
                                                                          index]
                                                                      .title
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  children: [
                                                                TextSpan(
                                                                    text: loseWeightDataOne[
                                                                            index]
                                                                        .detail
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400))
                                                              ])),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Image(
                                                            fit: BoxFit.cover,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.15,
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.25,
                                                            image: AssetImage(
                                                                loseWeightDataOne[
                                                                        index]
                                                                    .image
                                                                    .toString()))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : index == 1 && user[0].goals == "Lose Weight"
                                                  ? Column(
                                                      children: List.generate(
                                                        loseWeightDataTwo
                                                            .length,
                                                        (index) => Row(
                                                          children: [
                                                            Expanded(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: loseWeightDataTwo[
                                                                              index]
                                                                          .title
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                      children: [
                                                                    TextSpan(
                                                                        text: loseWeightDataTwo[index]
                                                                            .detail
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w400))
                                                                  ])),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Image(
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.15,
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.25,
                                                                image: AssetImage(
                                                                    loseWeightDataTwo[
                                                                            index]
                                                                        .image
                                                                        .toString()))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : index == 2 && user[0].goals == "Lose Weight"
                                                      ? Column(
                                                          children:
                                                              List.generate(
                                                            loseWeightDataThree
                                                                .length,
                                                            (index) => Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      RichText(
                                                                          text: TextSpan(
                                                                              text: loseWeightDataThree[index].title.toString(),
                                                                              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                                                                              children: [
                                                                        TextSpan(
                                                                            text: loseWeightDataThree[index]
                                                                                .detail
                                                                                .toString(),
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w400))
                                                                      ])),
                                                                ),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Image(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.15,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.25,
                                                                    image: AssetImage(loseWeightDataThree[
                                                                            index]
                                                                        .image
                                                                        .toString()))
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : index == 3 && user[0].goals == "Lose Weight"
                                                          ? Column(
                                                              children:
                                                                  List.generate(
                                                                loseWeightDataFour
                                                                    .length,
                                                                (index) => Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: RichText(
                                                                          text: TextSpan(text: loseWeightDataFour[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                        TextSpan(
                                                                            text: loseWeightDataFour[index]
                                                                                .detail
                                                                                .toString(),
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w400))
                                                                      ])),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Image(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.15,
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.25,
                                                                        image: AssetImage(loseWeightDataFour[index]
                                                                            .image
                                                                            .toString()))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : index == 0 && user[0].goals == "Gain Weight"
                                                              ? Column(
                                                                  children: List
                                                                      .generate(
                                                                    gainWeightDataOne
                                                                        .length,
                                                                    (index) =>
                                                                        Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: RichText(
                                                                              text: TextSpan(text: gainWeightDataOne[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                            TextSpan(
                                                                                text: gainWeightDataOne[index].detail.toString(),
                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                          ])),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Image(
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            height: MediaQuery.sizeOf(context).height *
                                                                                0.15,
                                                                            width: MediaQuery.sizeOf(context).width *
                                                                                0.25,
                                                                            image:
                                                                                AssetImage(gainWeightDataOne[index].image.toString()))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : index == 1 && user[0].goals== "Gain Weight"
                                                                  ? Column(
                                                                      children:
                                                                          List.generate(
                                                                        gainWeightDataTwo
                                                                            .length,
                                                                        (index) =>
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: RichText(
                                                                                  text: TextSpan(text: gainWeightDataTwo[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                TextSpan(text: gainWeightDataTwo[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                              ])),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Image(
                                                                                fit: BoxFit.cover,
                                                                                height: MediaQuery.sizeOf(context).height * 0.15,
                                                                                width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                image: AssetImage(gainWeightDataTwo[index].image.toString()))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : index == 2 && user[0].goals== "Gain Weight"
                                                                      ? Column(
                                                                          children:
                                                                              List.generate(
                                                                            gainWeightDataThree.length,
                                                                            (index) =>
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: RichText(
                                                                                      text: TextSpan(text: gainWeightDataThree[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                    TextSpan(text: gainWeightDataThree[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                                  ])),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 20,
                                                                                ),
                                                                                Image(fit: BoxFit.cover, height: MediaQuery.sizeOf(context).height * 0.15, width: MediaQuery.sizeOf(context).width * 0.25, image: AssetImage(gainWeightDataThree[index].image.toString()))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : index == 3 && user[0].goals== "Gain Weight"
                                                                          ? Column(
                                                                              children: List.generate(
                                                                                gainWeightDataFour.length,
                                                                                (index) => Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: RichText(
                                                                                          text: TextSpan(text: gainWeightDataFour[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                        TextSpan(text: gainWeightDataFour[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                                      ])),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 20,
                                                                                    ),
                                                                                    Image(fit: BoxFit.cover, height: MediaQuery.sizeOf(context).height * 0.15, width: MediaQuery.sizeOf(context).width * 0.25, image: AssetImage(gainWeightDataFour[index].image.toString()))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : index == 0 && user[0].goals== "Maintain Weight"
                                                                              ? Column(
                                                                                  children: List.generate(
                                                                                    maintainWeightDataOne.length,
                                                                                    (index) => Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: RichText(
                                                                                              text: TextSpan(text: maintainWeightDataOne[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                            TextSpan(text: maintainWeightDataOne[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                                          ])),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          width: 20,
                                                                                        ),
                                                                                        Image(fit: BoxFit.cover, height: MediaQuery.sizeOf(context).height * 0.15, width: MediaQuery.sizeOf(context).width * 0.25, image: AssetImage(maintainWeightDataOne[index].image.toString()))
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : index == 1 && user[0].goals== "Maintain Weight"
                                                                                  ? Column(
                                                                                      children: List.generate(
                                                                                        maintainWeightDataTwo.length,
                                                                                        (index) => Row(
                                                                                          children: [
                                                                                            Expanded(
                                                                                              child: RichText(
                                                                                                  text: TextSpan(text: maintainWeightDataTwo[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                                TextSpan(text: maintainWeightDataTwo[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                                              ])),
                                                                                            ),
                                                                                            const SizedBox(
                                                                                              width: 20,
                                                                                            ),
                                                                                            Image(fit: BoxFit.cover, height: MediaQuery.sizeOf(context).height * 0.15, width: MediaQuery.sizeOf(context).width * 0.25, image: AssetImage(maintainWeightDataTwo[index].image.toString()))
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : index == 2 && user[0].goals== "Maintain Weight"
                                                                                      ? Column(
                                                                                          children: List.generate(
                                                                                            maintainWeightDataThree.length,
                                                                                            (index) => Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  child: RichText(
                                                                                                      text: TextSpan(text: maintainWeightDataThree[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                                    TextSpan(text: maintainWeightDataThree[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                                                  ])),
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 20,
                                                                                                ),
                                                                                                Image(fit: BoxFit.cover, height: MediaQuery.sizeOf(context).height * 0.15, width: MediaQuery.sizeOf(context).width * 0.25, image: AssetImage(maintainWeightDataThree[index].image.toString()))
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : index == 3 && user[0].goals== "Maintain Weight"
                                                                                          ? Column(
                                                                                              children: List.generate(
                                                                                                maintainWeightDataFour.length,
                                                                                                (index) => Row(
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      child: RichText(
                                                                                                          text: TextSpan(text: maintainWeightDataFour[index].title.toString(), style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), children: [
                                                                                                        TextSpan(text: maintainWeightDataFour[index].detail.toString(), style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400))
                                                                                                      ])),
                                                                                                    ),
                                                                                                    const SizedBox(
                                                                                                      width: 20,
                                                                                                    ),
                                                                                                    Image(fit: BoxFit.cover, height: MediaQuery.sizeOf(context).height * 0.15, width: MediaQuery.sizeOf(context).width * 0.25, image: AssetImage(maintainWeightDataFour[index].image.toString()))
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          : const SizedBox()),
                                ),
                                20.heightBox,
                                // Widget to add vertical space
                              ],
                            );
                          },
                        )),
              ),
            ),
          ],
        ).box.make(), // Wrapping the Column in a Box and making it
      ),
    );
  }
}

class DietModel {
  String title;
  String detail;
  String image;

  DietModel({required this.title, required this.detail, required this.image});
}
