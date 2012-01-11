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
	public class ButtonOnOffStates implements IButtonStates{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var animeTarget:Sprite;
		private var animeOnState:String = 'OnState';
		private var animeOffState:String = 'OffState';
		/**
		 * anime target ON visual state params
		 */
		private var onAnimeTime:Number = .15;
		private var onColor:String = '0x3399FF';
		private var onAlphaValue:int = 1;
		/**
		 * anime target OFF visual state params
		 */
		private var offAnimeTime:Number = 1;
		private var offColor:String = '0x000000';
		private var offAlphaValue:int = 0;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ButtonOnOffStates(){};
		/**
		 * Class interface takes two params; animeTarget:MovieClip = the anime 
		 * target, actionType:String = DownState, OverState, OutState, or UpState.
		 */		
		public function buttonStatesInterface(animeTarget:Sprite, actionType:String):void{
			this.animeTarget = animeTarget;
			animeActionType(actionType);
		}
		private function animeActionType(actionType:String):void{
			if (actionType == animeOnState){
				bttnOn();
			} else if (actionType == animeOffState){
				bttnOff();
			}
		}
		/** 
		 * Button visual states.
		 */		
		private function bttnOn ():void {
			TweenMax.to (animeTarget,onAnimeTime,{tint:onColor, alpha:onAlphaValue, ease:Sine.easeOut});
		}
		private function bttnOff ():void {
			TweenMax.to (animeTarget,offAnimeTime,{tint:offColor, alpha:offAlphaValue, ease:Sine.easeOut});
		}
	}
}