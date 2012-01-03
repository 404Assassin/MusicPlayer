////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view {
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
	import com.cw.view.buttons.PlayButton;
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
	public class MusicPlayerUI implements ISubject{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var uiInvokedObserver:InvokedObserver;
		private var observer:ISubject;
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
		public function MusicPlayerUI () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function buildMusicPlayerUI ():void {
			addInterface();
		}
		public function getMusicPlayerUI ():Sprite {
			return theMusicPlayerUI
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
			observer.notifyObservers(theButtonState);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
		}
		public function update (observer:ISubject, infoObject:String):void {
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function addInterface ():void {
			theMusicPlayerUI = new Sprite();
			theMusicPlayerUI.addChild(theMusicPlayer);
			stopButton(theMusicPlayerUI);
			playButton(theMusicPlayerUI);
		}
		private function stopButton (theMusicPlayerUI:Sprite):void {
			var buttonHolder:Sprite = new Sprite();
			theMusicPlayerUI.addChild(buttonHolder);
			var theStopButton:StopButton = new StopButton();
			theStopButton.addObserver(observer);
			theStopButton.setButton('stop');
			var stopButton:Sprite = theStopButton.getButton();
			buttonHolder.addChild(stopButton);
			stopButton.x = 36;
			stopButton.y = 150;
		}
		private function playButton (theMusicPlayerUI:Sprite):void {
			var buttonHolder:Sprite = new Sprite();
			theMusicPlayerUI.addChild(buttonHolder);
			var thePlayButton:PlayButton = new PlayButton();
			thePlayButton.addObserver(observer);
			thePlayButton.setButton('play');
			var playButton:Sprite = thePlayButton.getButton();
			buttonHolder.addChild(playButton);
			playButton.x = 60;
			playButton.y = 150;
		}
	}
}