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
   import SharedObjects.BaseInterfacePieces.TCButton;
   import flash.events.MouseEvent;
   import com.greensock.TweenLite;

   public class ModMenu extends Sprite
   {
      
      private var m_background:Sprite;
      
      private var m_settingTexts:Vector.<TextField>;
      
      private var m_toggleButtons:Vector.<ToggleButton>;
      
      private var m_toggleTexts:Vector.<String>;      

      private var m_toggleDict:Dictionary;

      private var m_modSelectHolder:Sprite; //for scrolling

      private var m_upButton:TCButton;

      private var m_downButton:TCButton;

      private var m_modSelectMask:Sprite;

      private var  m_scrollPosition:int = 0; //current scroll position

      private var m_scrollMax:int = 4; //max scroll position

      public function ModMenu()
      {
         super();
         this.m_toggleTexts = new Vector.<String>();
         this.m_toggleTexts.push("Zanyu","Stingaray","Arkvian","Ophan"); //still need this for ordering. Make as small as possibe
         this.m_toggleDict = new Dictionary();
         this.m_toggleDict["Example"] = ["Tooltip description about the Example mod.", "Toggle1 (the minion)", "Extra toggles like this"];
         this.m_toggleDict["Zanyu"] = ["Bring the might of the legendary beast to your team! Featuring a custom Skill Tree, and powerful moves, they can be found in Floor 5-2!", "dirtFish"];
         this.m_toggleDict["Stingaray"] = ["A fearsome minion of the sea, ready to bring a Water-infused playstyle! Swim over to Stingaray in Floor 1-3, and 3-1!", "waterRay1", "waterRay2"];
         this.m_toggleDict["Arkvian"] = ["A holy counterpart to Airmony and Falcona, a serene bird prepared to become the next party member! Soar to Arkvian in Floor 1-4 and Arkclaw in Floor 4-2", "holyBirb1", "holyBirb2"];
         this.m_toggleDict["Ophan"] = ["Cultivate a curious one-eyed creature into a fast, lethal minion under your command! Find Ophan in 4-2 and Adophan in 5-3!", "HolyEye1", "HolyEye2", "HolyEye3"];

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
         _loc1_.align = TextFormatAlign.LEFT;

         //scrolling window
         this.m_modSelectHolder = new Sprite();
         this.m_modSelectHolder.x = 10;
         this.m_modSelectHolder.y = 40;
         addChild(this.m_modSelectHolder);
         this.m_modSelectMask = new Sprite(); //a mask?
         this.m_modSelectMask.x = 5; //who knows what these should be lol
         this.m_modSelectMask.y = 30;
         this.m_modSelectMask.graphics.beginFill(5592405);
         this.m_modSelectMask.graphics.drawRect(0,0,200,230); //testing it: increase Y coords
         this.m_modSelectMask.graphics.endFill();
         addChild(this.m_modSelectMask);
         this.m_modSelectHolder.mask = this.m_modSelectMask;

         var _loc4_:int = 0;
         while(_loc4_ < this.m_settingTexts.length)
         {
            this.m_settingTexts[_loc4_] = new TextField();
            this.m_settingTexts[_loc4_].embedFonts = true;
            this.m_settingTexts[_loc4_].defaultTextFormat = _loc1_;
            this.m_settingTexts[_loc4_].wordWrap = true;
            this.m_settingTexts[_loc4_].autoSize = TextFieldAutoSize.LEFT;
            this.m_settingTexts[_loc4_].text = this.m_toggleTexts[_loc4_];
            this.m_settingTexts[_loc4_].width = 80;
            this.m_settingTexts[_loc4_].x = 10;
            this.m_settingTexts[_loc4_].y = 11 + _loc4_ * 38;
            this.m_settingTexts[_loc4_].selectable = false;
            this.m_modSelectHolder.addChild(this.m_settingTexts[_loc4_]); //adding to the mod select holder instead
            this.m_toggleButtons[_loc4_] = new ToggleButton(this.ToggleCarousel,"menus_settings_onButton","menus_settings_offButton","","",this.m_toggleTexts[_loc4_]); //last param is text of button
            this.m_toggleButtons[_loc4_].x = 98;
            this.m_toggleButtons[_loc4_].y = 11 + _loc4_ * 38;
            this.m_modSelectHolder.addChild(this.m_toggleButtons[_loc4_]);
            _loc4_++;
         }
         //the buttons
         this.m_upButton = new TCButton(this.UpPressed,"minionPedia_upArrow");
         this.m_upButton.x = 175; //making this stuff up
         this.m_upButton.y = 10;
         this.addChild(this.m_upButton);
         this.m_downButton = new TCButton(this.DownPressed,"minionPedia_upArrow"); //down is just "Up" flipped
         this.m_downButton.x = 175;
         this.m_downButton.y = 280;
         this.m_downButton.scaleY = -1; //flippie
         this.addChild(this.m_downButton);
         visible = false;
      }
      
      private function UpPressed(param1:MouseEvent) : void //scroll up event
      {
         trace("Up Pressed");
         --this.m_scrollPosition;
         this.UpdateTheScrollBoxPosition();
      }
      
      private function DownPressed(param1:MouseEvent) : void //scroll down event
      {
         trace("Down Pressed");
         ++this.m_scrollPosition;
         this.UpdateTheScrollBoxPosition();
      }

      private function UpdateTheScrollBoxPosition() : void
      {
         trace("Updating scroll box position");
         if(this.m_scrollPosition < 0) //edge case checks to prevent stupid scrolling
         {
            this.m_scrollPosition = 0;
         }
         if(this.m_scrollPosition > this.m_scrollMax)
         {
            this.m_scrollPosition = this.m_scrollMax;
         }
         //perform a tween to the new position
         var _loc1_:Number = 43 + -this.m_modSelectHolder.height / 20 * this.m_scrollPosition;
         TweenLite.to(this.m_modSelectHolder,0.5,{"y":_loc1_});
         //hide the buttons if at the top or bottom
         if(this.m_scrollPosition == 0)
         {
            this.m_upButton.visible = false;
         }
         else
         {
            this.m_upButton.visible = true;
         }
         if(this.m_scrollPosition == this.m_scrollMax)
         {
            this.m_downButton.visible = false;
         }
         else
         {
            this.m_downButton.visible = true;
         }
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
         this.m_scrollPosition = 0;
         this.UpdateTheScrollBoxPosition();
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

