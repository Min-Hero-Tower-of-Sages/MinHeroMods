package MainMenu
{
   import SharedObjects.BaseInterfacePieces.ToggleButton;
   import Utilities.Singleton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ModMenu extends Sprite
   {
      
      private var m_background:Sprite;
      
      private var m_settingTexts:Vector.<TextField>;
      
      private var m_toggleButtons:Vector.<ToggleButton>;
      
      private var m_toggleTexts:Vector.<String>;
      
      public function ModMenu()
      {
         super();
         this.m_toggleTexts = new Vector.<String>();
         this.m_toggleTexts.push("Zanyu","Stingaray","Mantaray","Arkvian", "Arkclaw","Adophan", "Ophan", "Ophance");
      }
      
      public function LoadSprites() : void
      {
         this.m_background = Singleton.utility.m_spriteHandler.CreateSprite("mainMenu_modMenuBackground");
         addChild(this.m_background);
         this.m_settingTexts = new Vector.<TextField>(Singleton.staticData.m_all_mods.length - 3);
         this.m_toggleButtons = new Vector.<ToggleButton>(Singleton.staticData.m_all_mods.length - 3);
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
            this.m_toggleButtons[_loc4_] = new ToggleButton(this.ToggleCarousel,"menus_settings_onButton","menus_settings_offButton","","",Singleton.staticData.m_all_mods[_loc4_]);
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
      
      public function ToggleCarousel(param1:String) : void
      {
         Singleton.dynamicData.m_isMod[param1] = !Singleton.dynamicData.m_isMod[param1];
         trace("Toggled: " + param1 + " to " + Singleton.dynamicData.m_isMod[param1]);
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

