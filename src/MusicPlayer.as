////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package  {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: musicPlayer
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Dec 22, 2011
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
	import com.cw.view.MusicPlayerUI;
	import flash.display.Sprite;
	import flash.display.Stage;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// SWF characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	[SWF(width = 800, height = 800, backgroundColor = 0x666666, frameRate = 30)]
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MusicPlayer extends Sprite {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var uiInvokedObserver:ISubject = new InvokedObserver();
		private var stateInvokedObserver:ISubject = new InvokedObserver();
		private var theMusicPlayerUIHolder:Sprite;
		private var theMusicPlayerUI:MusicPlayerUI;
		private var theMusicPlayerState:MusicPlayerState;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayer () {
			trace(" ::::::::::: musicPlayer.musicPlayer() ");
			initTheBuild();
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Get the Music Player for use through composition.
		 */
		public function getMusicPlayer ():Sprite {
			return theMusicPlayerUIHolder;
		}
		/**
		 * Add the Music Player to the stage.
		 */
		public function addMusicPlayerToStage ():void {
			stage.addChild(theMusicPlayerUIHolder);
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function initTheBuild ():void {
			addMusicPlayerUI();
			addMusicPlayerToStage();
			musicPlayerState();
		}
		/**
		 * Add the Music Player user interface.
		 */
		private function addMusicPlayerUI ():void {
			theMusicPlayerUI = new MusicPlayerUI();
			addMusicPlayerUIObservers(theMusicPlayerUI);
			theMusicPlayerUI.buildMusicPlayerUI();
			theMusicPlayerUIHolder = theMusicPlayerUI.getMusicPlayerUI();
		}
		/**
		 * Envoke the Music Player state controler.
		 */
		private function musicPlayerState ():void {
			theMusicPlayerState = new MusicPlayerState();
			addStateMachineObservers(theMusicPlayerState);
			theMusicPlayerState.initStateMachine();
			uiInvokedObserver
		}
		/**
		 * Add the Music Player user interface observer.
		 */
		private function addMusicPlayerUIObservers (theMusicPlayerUI:MusicPlayerUI):void {
			theMusicPlayerUI.addObserver(uiInvokedObserver);
		}
		/**
		 * Add the State Machine observer.
		 */
		private function addStateMachineObservers (theMusicPlayerState:MusicPlayerState):void {
			theMusicPlayerState.addObserver(uiInvokedObserver);
		}
	}
}