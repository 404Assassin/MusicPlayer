package com.cw.view.text{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * Class discription: public class DynamicTextField
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * contact: christian@worleydev.com
	 * created: Nov 25, 2011
	 * TODO;  
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.view.shapeCreators.CreateShape;
	import com.greensock.TweenMax;
	import com.greensock.loading.LoaderMax;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class CDynamicTextField implements ICDynamicTextField {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var theTextFieldHolder:Sprite;
		private var theTextFieldBGHolder:Sprite;
		private var textHorizontalBuffer:uint = 20;
		private var textVerticalBuffer:uint = 20;
		private var textHorizontalOffset:Number = 4;
		private var textVerticalOffset:Number = 2;
		private var textContent:String
		private var textFieldWidth:uint
		private var textFieldHeight:uint
		private var textFieldBackground:Boolean
		private var textFieldBackgroundColor:uint
		private var textFieldMultiline:Boolean
		private var textFieldWordWrap:Boolean
		private var xPlacement:int;
		private var yPlacement:int;
		private var dynamicButtonObserver:InvokedObserver
		private var eventTarget:Object;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function CDynamicTextField(){};
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * Dynamic text field interfaces for composition 
		 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		public function textFieldInterface(textContent:String, textFieldWidth:uint, textFieldHeight:uint, textFieldBackground:Boolean, textFieldBackgroundColor:uint, textFieldMultiline:Boolean, textFieldWordWrap:Boolean):void{
			this.textContent = textContent;
			this.textFieldWidth = textFieldWidth
			this.textFieldHeight = textFieldHeight
			this.textFieldBackground = textFieldBackground;
			this.textFieldBackgroundColor = textFieldBackgroundColor;
			this.textFieldMultiline = textFieldMultiline;
			this.textFieldWordWrap = textFieldWordWrap;
			this.textHorizontalOffset = textHorizontalOffset;
			this.textVerticalOffset = textVerticalOffset;
			textFieldHolder()
		}
		public function getTheTextField():Sprite{
			return theTextFieldHolder
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function textFieldHolder():void {
			theTextFieldHolder = new Sprite();
			textFieldBGHolder();
		}
		private function textFieldBGHolder():void {
			theTextFieldBGHolder = new Sprite();
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, theTextFieldBGHolder, 0, 0, 20, 20)
			TweenMax.to (theTextFieldBGHolder, 0, {alpha:.5, tint:0xFFFFFF});
			//theTextFieldBGHolder.filters = [new DropShadowFilter(2, 45, 0x000000, 1, 2, 2, 1, 2, true, true, false)];
			theTextFieldHolder.addChild(theTextFieldBGHolder);
			addTextFieldText();
		}
		private function addTextFieldText():void{
			var textField:TextField = new TextField();
			textField.embedFonts = false;
			textField.background = textFieldBackground;
			textField.backgroundColor = textFieldBackgroundColor;
			textField.width = textFieldWidth - textHorizontalBuffer;
			textField.height = textFieldHeight - textVerticalBuffer;
			textField.multiline = textFieldMultiline;
			textField.wordWrap = textFieldWordWrap;
			textField.autoSize = TextFieldAutoSize.NONE;
			textField.antiAliasType = AntiAliasType.ADVANCED; 
			textField.styleSheet = LoaderMax.getContent("flashStyleSheet");;
			textField.htmlText = textContent;
			theTextFieldHolder.addChild(textField);
			TweenMax.to(textField, 0, {dropShadowFilter:{color:0x000000, alpha:.5, blurX:5, blurY:5, distance:5}});
			resizeTextFieldBG(textField);
		}
		private function resizeTextFieldBG(textField:TextField):void{
			theTextFieldBGHolder.width = textFieldWidth;
			theTextFieldBGHolder.height = textFieldHeight;
			theTextFieldBGHolder.x = 0;
			theTextFieldBGHolder.y = 0;
			centerTextWithBackground(textField)
		}
		private function centerTextWithBackground(textField:TextField):void{
			var totalTextWidth:int = textField.width;
			textField.x = (textFieldWidth-totalTextWidth) * .5;
			var totalTextHeight:int = textField.height;
			textField.y = (textFieldHeight - totalTextHeight)*.5;
		}
	}
}