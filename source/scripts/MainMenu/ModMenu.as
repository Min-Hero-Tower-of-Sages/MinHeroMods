package MainMenu
{
   import SharedObjects.BaseInterfacePieces.ToggleButton;
   import Utilities.Singleton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;

   public class ModMenu extends Sprite
   {
      
      private var m_background:Sprite;
      
      private var m_settingTexts:Vector.<TextField>;
      
      private var m_toggleButtons:Vector.<ToggleButton>;
      
      private var m_toggleTexts:Vector.<String>;      

      private var m_toggleDict:Dictionary;
      
      public function ModMenu()
      {
         super();
         this.m_toggleTexts = new Vector.<String>();
         this.m_toggleTexts.push("Zanyu","Stingaray/Mantaray","Arkvian/Arkclaw","Adophan/Ophan/Ophance"); //still need this for ordering
         this.m_toggleDict = new Dictionary();
         this.m_toggleDict["Example"] = ["Tooltip description about the Example mod.", "Toggle1 (the minion)", "Extra toggles like this"];
         this.m_toggleDict["Zanyu"] = ["Bring the might of the legendary beast to your team! Featuring a custom Skill Tree, and powerful moves, they can be found in Floor 5-2!", "dirtFish"];
         this.m_toggleDict["Stingaray/Mantaray"] = ["A fearsome minion of the sea, ready to bring a Water-infused playstyle! Swim over to Stingaray in Floor 1-3, and 3-1!", "waterFish1", "waterFish2"];
         this.m_toggleDict["Arkvian/Arkclaw"] = ["A holy counterpart to Airmony and Falcona, a serene bird prepared to become the next party member! Soar to Arkvian in Floor 1-4 and Arkclaw in Floor 4-2", "holyBirb1", "holyBirb2"];
         this.m_toggleDict["Adophan/Ophan/Ophance"] = ["Cultivate a curious one-eyed creature into a fast, lethal minion under your command! Find Ophan in 4-2 and Adophan in 5-3!", "HolyEye1", "HolyEye2", "HolyEye3"];

      }
      
      public function LoadSprites() : void
      {
         this.m_background = Singleton.utility.m_spriteHandler.CreateSprite("mainMenu_modMenuBackground");
         addChild(this.m_background);
         this.m_settingTexts = new Vector.<TextField>(this.m_toggleTexts.length);
         this.m_toggleButtons = new Vector.<ToggleButton>(this.m_toggleTexts.length);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 16448250;
         _loc1_.size = 16;
         _loc1_.font = "BurbinCasual";
         _loc1_.align = TextFormatAlign.CENTER;
         var _loc4_:int = 0;
         while(_loc4_ < this.m_settingTexts.length)
         {
            this.m_settingTexts[_loc4_] = new TextField();
            this.m_settingTexts[_loc4_].embedFonts = true;
            _loc1_.size = 16;
            _loc1_.align = TextFormatAlign.LEFT;
            this.m_settingTexts[_loc4_].defaultTextFormat = _loc1_;
            this.m_settingTexts[_loc4_].wordWrap = true;
            this.m_settingTexts[_loc4_].autoSize = TextFieldAutoSize.LEFT;
            this.m_settingTexts[_loc4_].text = this.m_toggleTexts[_loc4_];
            this.m_settingTexts[_loc4_].width = 150;
            this.m_settingTexts[_loc4_].x = 12;
            this.m_settingTexts[_loc4_].y = 45 + _loc4_ * 38;
            this.m_settingTexts[_loc4_].selectable = false;
            addChild(this.m_settingTexts[_loc4_]);
            this.m_toggleButtons[_loc4_] = new ToggleButton(this.ToggleCarousel,"menus_settings_onButton","menus_settings_offButton","","",this.m_toggleTexts[_loc4_]); //last param is text of button
            this.m_toggleButtons[_loc4_].x = 100;
            this.m_toggleButtons[_loc4_].y = 51 + _loc4_ * 38;
            addChild(this.m_toggleButtons[_loc4_]);
            _loc4_++;
         }
         visible = false;
      }
      
      public function BringIn() : void
      {
         var i:int = 0;
         while(i < this.m_toggleButtons.length)
         {
            this.m_toggleButtons[i].m_isToggleOn = Singleton.dynamicData.m_isMod[Singleton.staticData.m_all_mods[i]];
            i++;
         }
         Singleton.utility.m_screenControllers.m_topDownScreen.m_topDownMenuScreen.ApplyMenuBringInAnimationJustFade(this);
      }
      
      public function ToggleCarousel(param1:String) : void //param1 is the button name
      {
         //first thing is to locate the mod group. This gets us the list of mod toggles, as each minion is considered a separate mod, but are meant to be part of a group
         for(var k in this.m_toggleDict) //for each mod group
         {
            //trace("Key: " + k + " Value: " + this.m_toggleDict[k]);
            if(param1 == k) //if the button name is the specific mod group name
            {
               //begin to get all toggles
               var i:int = 1; //starts on 1 as we skip the description
               while(i < this.m_toggleDict[k].length) //for each toggle in the group
               {
                  var toggleName:String = this.m_toggleDict[k][i]; //get the toggle name (mod codename)
                  Singleton.dynamicData.m_isMod[toggleName] = !Singleton.dynamicData.m_isMod[toggleName]; //toggle time
                  trace("Toggled: " + toggleName + " to " + Singleton.dynamicData.m_isMod[toggleName]);
                  i++; //go through all toggles
               }
               break; //break out of the for loop, we found our group
            }
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.m_toggleButtons.length)
         {
            this.m_toggleButtons[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

