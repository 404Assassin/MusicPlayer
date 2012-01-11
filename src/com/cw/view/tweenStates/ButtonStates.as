////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package  com.cw.view.tweenStates{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: Button States class - animes for button event states
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Sep 2, 2011
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ButtonStates implements IButtonStates{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var animeTarget:Sprite;
		private var animeDownState:String = 'DownState';
		private var animeOverState:String = 'OverState';
		private var animeOutState:String = 'OutState';
		private var animeUpState:String = 'UpState';
		/**
		 *	anime target DOWN visual state params
		 */		
		private var downAnimeTime:Number = .25;
		private var downGlowColor:String = '0xFFFFFF';
		private var downAlphaValue:Number = .55;
		private var downBlurXValue:Number = 5;
		private var downBlurYValue:Number = 5;
		private var downGlowStrength:Number = 5;
		private var downGlowQuality:Number = 5;
		/**
		 * anime target OVER visual state params
		 */
		private var overAnimeTime:Number = .25;
		private var overGlowColor:String = '0xAAAAAA';
		private var overAlphaValue:Number = 1;
		private var overBlurXValue:Number = 3;
		private var overBlurYValue:Number = 3;
		private var overGlowStrength:Number = 5;
		private var overGlowQuality:Number = 5;
		/**
		 * anime target OUT visual state params 
		 */		
		private var outAnimeTime:Number = 1;
		private var outGlowColor:String = '0xAAAAAA';
		private var outAlphaValue:Number = 0;
		private var outBlurXValue:Number = 0;
		private var outBlurYValue:Number = 0;
		private var outGlowStrength:Number = 0;
		private var outGlowQuality:Number = 0;
		/**
		 * anime target UP visual state params 
		 */		
		private var upAnimeTime:Number = .25;
		private var upGlowColor:String = '0xAAAAAA';
		private var upAlphaValue:Number = 1;
		private var upBlurXValue:Number = 3;
		private var upBlurYValue:Number = 3;
		private var upGlowStrength:Number = 5;
		private var upGlowQuality:Number = 5;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ButtonStates(){};
		/**
		 * Class interface takes two params; animeTarget:MovieClip = the anime 
		 * target, actionType:String = DownState, OverState, OutState, or UpState.
		 */		
		public function buttonStatesInterface(animeTarget:Sprite, actionType:String):void{
			this.animeTarget = animeTarget;
			animeActionType(actionType);
		}
		private function animeActionType(actionType:String):void{
			if (actionType == animeDownState){
				onBttnDown();
			} else if (actionType == animeOverState){
				onBttnOver();
			} else if (actionType == animeOutState){
				onBttnRollOut();
			} else if (actionType == animeUpState){
				onBttnUp();
			} 
		}
		/**
		 * Mouse event visual animations.
		 */
		private function onBttnDown ():void {
			TweenMax.to (animeTarget,downAnimeTime,{
				glowFilter:{color:downGlowColor,alpha:downAlphaValue,blurX:downBlurXValue,blurY:downBlurYValue,strength:downGlowStrength,quality:downGlowQuality},
				ease:Sine.easeOut});
		}
		private function onBttnOver ():void {
			TweenMax.to (animeTarget,overAnimeTime,{
				glowFilter:{color:overGlowColor,alpha:overAlphaValue,blurX:overBlurXValue,blurY:overBlurYValue,strength:overGlowStrength,quality:overGlowQuality},
				ease:Sine.easeOut});
		}
		private function onBttnRollOut ():void {
			TweenMax.to (animeTarget,outAnimeTime,{
				glowFilter:{color:outGlowColor,alpha:outAlphaValue,blurX:outBlurXValue,blurY:outBlurYValue,strength:outGlowStrength,quality:outGlowQuality},
				ease:Sine.easeOut});
		}
		private function onBttnUp ():void {
			TweenMax.to (animeTarget,upAnimeTime,{
				glowFilter:{color:upGlowColor,alpha:upAlphaValue,blurX:upBlurXValue,blurY:upBlurYValue,strength:upGlowStrength,quality:upGlowQuality},
				ease:Sine.easeOut});
		}
	}
}