////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package {
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
	import com.cw.model.MP3LoadQueue;
	import com.cw.model.MusicPlayerState;
	import com.cw.utilities.preloaders.OneBarPreloader;
	import com.cw.view.MusicPlayerUI;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// SWF characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	[SWF(width = 800, height = 800, backgroundColor = 0x666666, frameRate = 30)]
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MusicPlayer extends Sprite implements ISubject{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var uiInvokedObserver:ISubject = new InvokedObserver();
		private var theMusicPlayerUIHolder:Sprite;
		private var theMusicPlayerUI:MusicPlayerUI;
		private var theMusicPlayerState:MusicPlayerState;
		private var theOneBarPreloader:OneBarPreloader;
//		private var sound:MP3Loader;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayer () {
			addObserver (uiInvokedObserver);
			initTheBuild();
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Get the Music Player UI for use through composition.
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
		/**
		 * InvokedObserver interface, reference update, and subscription with
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver (observer:ISubject):void {
			this.observer = observer;
			observer.addObserver(this);
		}
		/**
		 * InvokedObserver notification
		 */
		public function notifyObservers (infoObject:String):void {
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
			this.observer = observer;
			observer.removeObserver(this);
		}
		public function update (infoObject:String):void {
			try {
				this[infoObject]();
			} catch(error:Error) {
				//trace(" ::::::::::: skip non methods!!!!! ");
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function initTheBuild ():void {
			loadMp3();
		}
		private function preloader():void{
			theOneBarPreloader = new OneBarPreloader();
			theOneBarPreloader.initProgressBar();
			
		}
		private function loadMp3 ():void {
			var theMP3LoadQueue:MP3LoadQueue = new MP3LoadQueue();
			theMP3LoadQueue.addObserver(uiInvokedObserver);
			theMP3LoadQueue.initMP3LoadQueue();
		}
		private function firstTractLoading():void{
			musicPlayerState();
			addMusicPlayerUI();
			addMusicPlayerToStage();
		}
		/**
		 * Called via observer update.
		 */		
		private function firstTractLoaded():void{
		}
		/**
		 * Called via observer update.
		 */		
		private function externalContentLoaded():void{
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
