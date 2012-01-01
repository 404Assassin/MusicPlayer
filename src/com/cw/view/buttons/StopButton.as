////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package  com.cw.view.buttons {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: StopButton
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Dec 26, 2011
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.model.MusicPlayerState;
	import com.cw.view.tweenStates.ButtonStates;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class StopButton implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var theStopButton:bttn_stop = new bttn_stop();
		private var theButtonState:String;
//		private var theMusicPlayerState:MusicPlayerState = new MusicPlayerState();
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function StopButton () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function setStopButton ():void {
			buttonBuild();
		}
		public function getStopButton ():Sprite {
			return theButton
		}
		/**
		 * InvokedObserver interface, reference update, and subscription with
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver (observer:ISubject):void {
			this.observer = observer;
			trace(" ::::::::::: StopButton.addObserver(observer) " + '\n' + observer + '\n' + this);
			observer.addObserver(this);
		}
		/**
		 * InvokedObserver notification
		 */
		public function notifyObservers (infoObject:Object):void {
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
		}
		public function update (observer:ISubject, infoObject:Object):void {
			trace(" ::::::::::: StopButton.update(observer, infoObject) " + '\n' + observer + '\n' + infoObject);
			buttonState(infoObject)
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function buttonBuild ():void {
			trace(" ::::::::::: StopButton.buttonBuild() " + '\n' + theStopButton + '\n' + theButton);
			theButton = new Sprite();
			theButton.addChild(theStopButton);
			theStopButton.x = 0;
			theStopButton.y = 0;
			addButtonEvents();
		}
		private function addButtonEvents ():void {
			theStopButton.buttonMode = true;
			theStopButton.doubleClickEnabled = true;
			theStopButton.addEventListener(MouseEvent.CLICK, placementTargetUp);
			theStopButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			theStopButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			theStopButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'OverState');
//			buttonStates.buttonStatesInterface(theStopButton.icon, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'OutState');
//			buttonStates.buttonStatesInterface(theStopButton.icon, 'OutState');
		}
		private function placementTargetDown (downEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'DownState');
//			buttonStates.buttonStatesInterface(theStopButton.icon, 'DownState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'UpState');
//			buttonStates.buttonStatesInterface(theStopButton.icon, 'UpState');
			theButtonState = 'stop';
			notifyObservers(theButtonState);
		}
		private function buttonState(infoObject:Object):void{
			if (infoObject == 'stop'){
				buttonStates.buttonStatesInterface(theStopButton.icon, 'OnState');
			} else {
				buttonStates.buttonStatesInterface(theStopButton.icon, 'OffState');
			}
		}
	}
}
