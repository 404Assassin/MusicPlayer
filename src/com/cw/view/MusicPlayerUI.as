////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package  com.cw.view{
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	/**
	 * class description: MusicPlayerInterface
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Dec 23, 2011
	 * TODO:
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.model.MusicPlayerState;
	import com.cw.view.buttons.StopButton;
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
	public class MusicPlayerUI implements ISubject/* ,IObserver*/ {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var uiInvokedObserver:InvokedObserver;
		private var observer:ISubject;
//		private var theMusicPlayerState:MusicPlayerState = new MusicPlayerState();
		private var theMusicPlayerUI:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var music_player:Sprite;
		private var theMusicPlayer:musicPlayerInterface = new musicPlayerInterface();
		private var theStopButton:bttn_stop = new bttn_stop();
		private var thePlayButton:bttn_play = new bttn_play();
		private var theButtonState:String;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayerUI(){}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function buildMusicPlayerUI():void{
			addInterface();
		}
		public function getMusicPlayerUI():Sprite{
			return theMusicPlayerUI
		}
		/**
		 * InvokedObserver interface, reference update, and subscription with 
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver(observer:ISubject):void{
			this.observer = observer;
			trace(" ::::::::::: MusicPlayerUI.registerObserver(observerInstanceReference) " + '\n' + observer + '\n' + this);
			observer.addObserver(this);
		}
		/**
		 * InvokedObserver notification
		 */
		public function notifyObservers(infoObject:Object):void{
			observer.notifyObservers(theButtonState);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver(observer:ISubject):void{
		}
		public function update(observer:ISubject, infoObject:Object):void{
			trace(" ::::::::::: MusicPlayerUI.update(infoObject) " + '\n' + observer + '\n' + infoObject);
		}

		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function addInterface():void{
			theMusicPlayerUI = new Sprite();
			theMusicPlayerUI.addChild(theMusicPlayer);
			stopButton(theMusicPlayerUI);
			playButton();
			
			addTheButtonEvents();
		}		
		private function stopButton(theMusicPlayerUI:Sprite):void{
			trace(" ::::::::::: MusicPlayerUI.stopButton(theMusicPlayerUI) " + '\n' + observer);
			
			var buttonHolder:Sprite = new Sprite();
			theMusicPlayerUI.addChild(buttonHolder);
			var theStopButton:StopButton =  new StopButton();
			theStopButton.addObserver(observer);
			theStopButton.setStopButton();
			var stopButton:Sprite = theStopButton.getStopButton();
			buttonHolder.addChild(stopButton);
			stopButton.x = 36;
			stopButton.y = 150;
		}
/*		private function stopButton():void{
			theMusicPlayerUI.addChild(theStopButton);
			theStopButton.x = 35;
			theStopButton.y = 150;
		}*/
		private function playButton():void{
			theMusicPlayerUI.addChild(thePlayButton);
			thePlayButton.x = 60;
			thePlayButton.y = 150;
		}
		
		private function addTheButtonEvents():void {
//			stopButtonEvents();
			playButtonEvents();
		}
/*		private function stopButtonEvents():void {
			theStopButton.buttonMode = true;
			theStopButton.doubleClickEnabled = true;
			theStopButton.addEventListener (MouseEvent.CLICK, placementTargetUp);
			theStopButton.addEventListener (MouseEvent.MOUSE_DOWN, placementTargetDown);
			theStopButton.addEventListener (MouseEvent.MOUSE_OUT, placementTargetOut);
			theStopButton.addEventListener (MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver(overEvent:Event):void{
			buttonStates.buttonStatesInterface(theStopButton.background, 'OverState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'OverState');
		}
		private function placementTargetOut(outEvent:Event):void{
			buttonStates.buttonStatesInterface(theStopButton.background, 'OutState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'OutState');
		}
		private function placementTargetDown(downEvent:Event):void{
			buttonStates.buttonStatesInterface(theStopButton.background, 'DownState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'DownState');
		}
		private function placementTargetUp(upEvent:Event):void{
			//theStopButton.mouseEnabled = false;
			buttonStates.buttonStatesInterface(theStopButton.background, 'UpState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'UpState');
			theMusicPlayerState.stop();
			theButtonState = 'stop';
			notifyObservers(theButtonState);
		}*/
		private function playButtonEvents():void {
			thePlayButton.buttonMode = true;
			thePlayButton.doubleClickEnabled = true;
			thePlayButton.addEventListener (MouseEvent.CLICK, playTargetUp);
			thePlayButton.addEventListener (MouseEvent.MOUSE_DOWN, playTargetDown);
			thePlayButton.addEventListener (MouseEvent.MOUSE_OUT, playTargetOut);
			thePlayButton.addEventListener (MouseEvent.MOUSE_OVER, playTargetOver);
		}
		private function playTargetOver(overEvent:Event):void{
			buttonStates.buttonStatesInterface(thePlayButton.background, 'OverState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'OverState');
		}
		private function playTargetOut(outEvent:Event):void{
			buttonStates.buttonStatesInterface(thePlayButton.background, 'OutState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'OutState');
		}
		private function playTargetDown(downEvent:Event):void{
			buttonStates.buttonStatesInterface(thePlayButton.background, 'DownState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'DownState');
		}
		private function playTargetUp(upEvent:Event):void{
			//thePlayButton.mouseEnabled = false;
			buttonStates.buttonStatesInterface(thePlayButton.background, 'UpState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'UpState');
//			theMusicPlayerState.play();
		}
	}	
}