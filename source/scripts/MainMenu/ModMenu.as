package MainMenu
{
   import SharedObjects.BaseInterfacePieces.TCButton;
   import Utilities.Singleton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import SharedObjects.BaseInterfacePieces.ToggleButton;
   import flash.utils.Dictionary;
   
   public class ModMenu extends Sprite //Custom ModMenu window
   {
      
      private var m_background:Sprite;
      
      private var m_settingTexts:Vector.<TextField>;
      
      private var m_toggleButtons:Vector.<ToggleButton>;

      private var m_toggleTexts:Vector.<String>;
      
      public function ModMenu()
      {
         super();
         this.m_toggleTexts = new Vector.<String>();
         this.m_toggleTexts.push("Zanyu"); //add mod name here
      }
      
      public function LoadSprites() : void //Loads sprites
      {
         this.m_background = Singleton.utility.m_spriteHandler.CreateSprite("mainMenu_modMenuBackground");  //load the background first
         addChild(this.m_background);
         //taken from SettingsMenu.as, the code to generate the toggles. Kept the text stuff for now, will change
         this.m_settingTexts = new Vector.<TextField>(Singleton.staticData.m_all_mods.length-3); //the array of text entries initialised. -3 from total for BMod. Cannot use m_TOTAL_MINIONS as it isn't created yet.
         this.m_toggleButtons = new Vector.<ToggleButton>(Singleton.staticData.m_all_mods.length-3); //the toggleable buttons
         var _loc1_:TextFormat = new TextFormat(); //text label formatting
         _loc1_.color = 16448250;
         _loc1_.size = 28;
         _loc1_.font = "BurbinCasual";
         _loc1_.align = TextFormatAlign.CENTER;
         var _loc4_:int = 0; //counter
         while(_loc4_ < this.m_settingTexts.length) //for each setting
         {
            this.m_settingTexts[_loc4_] = new TextField();  //define properties
            this.m_settingTexts[_loc4_].embedFonts = true; //use font
            _loc1_.size = 22; //font size
            _loc1_.align = TextFormatAlign.LEFT; //align left
            this.m_settingTexts[_loc4_].defaultTextFormat = _loc1_;
            this.m_settingTexts[_loc4_].wordWrap = true; //text will wrap
            this.m_settingTexts[_loc4_].autoSize = TextFieldAutoSize.LEFT;
            this.m_settingTexts[_loc4_].text =  this.m_toggleTexts[_loc4_]; //set text content
            this.m_settingTexts[_loc4_].width = 150; //set dimension
            this.m_settingTexts[_loc4_].x = 12; //have fun guessing these!
            this.m_settingTexts[_loc4_].y = 45 + _loc4_ * 38; //keep spacing the same
            this.m_settingTexts[_loc4_].selectable = false; //can't select, only click
            addChild(this.m_settingTexts[_loc4_]); //add label to window
            this.m_toggleButtons[_loc4_] = new ToggleButton(this.ToggleCarousel,"menus_settings_onButton","menus_settings_offButton","","", Singleton.staticData.m_all_mods[_loc4_]); //add the toggle button, with unique parameter (mod ID)
            this.m_toggleButtons[_loc4_].x = 100;
            this.m_toggleButtons[_loc4_].y = 51 + _loc4_ * 38; // Y is 6 more than text Y, keep same spacing
            addChild(this.m_toggleButtons[_loc4_]); //add button to window
            _loc4_++;
         }
         visible = false
      }
      
      public function BringIn() : void
      {
         //set defaults here
         for(var i:int = 0; i < this.m_toggleButtons.length; i++)
         {
            this.m_toggleButtons[i].m_isToggleOn = Singleton.dynamicData.m_isMod[Singleton.staticData.m_all_mods[i]]; //set the toggle button state to the current mod state
         }
         Singleton.utility.m_screenControllers.m_topDownScreen.m_topDownMenuScreen.ApplyMenuBringInAnimationJustFade(this);
      }
      
      public function ToggleCarousel(param1:String) : void
      {
         //Toggles based on parameter
         Singleton.dynamicData.m_isMod[param1] = !Singleton.dynamicData.m_isMod[param1]; //toggle the mod on/off.
         trace("Toggled: " + param1 + " to " + Singleton.dynamicData.m_isMod[param1]);
      }


      public function Update() : void
      {
         var _loc1_:int = 0; //updates each toggle
         while(_loc1_ < this.m_toggleButtons.length)
         {
            this.m_toggleButtons[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

